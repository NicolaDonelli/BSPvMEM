%%%%%%%%%%%%%%%%%%%%
%%%  SIMULATION  %%%
%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Bi-dimensional data generated from:                        %%%
%%% x(t) = h(t) * e(t)                                         %%%
%%% e(t) ~ p * LogNormal(-diag(Sigma1)/2,Sigma1) +             %%%
%%%       (1-p) * LogNormal(-diag(Sigma2)/2,Sigma2)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear all

filename = '../Data/BivariateSimulation/Input/tmp.mat';

%%%%%%%%%%%%%%%%%%%%%%
%%% Simulated Data %%%
%%%%%%%%%%%%%%%%%%%%%%

o_GMEM_TRUE = [0.4; 0.25];
B_GMEM_TRUE = [0.35  0.1 
               0.07  0.3];
A_GMEM_TRUE = [0.27 0.19
               0.18 0.31];     

n = 100e3;

p_Mixture = [0.7 0.3];
N_e00 = 1e6;
Sigma1 = [0.2   0.09
          0.09  0.1];
Sigma2 = [0.3   0.1
          0.1  0.2];
      
e1 = exp(mvnrnd(-0.5*diag(Sigma1),Sigma1, N_e00)); % N_e00 * 2
e2 = exp(mvnrnd(-0.5*diag(Sigma2),Sigma2, N_e00)); % N_e00 * 2
e12 = [e1 e2];
mixrand = mnrnd(1, p_Mixture, N_e00);
mix = zeros(0,1);
for i_mix=1:length(p_Mixture)
    mix = [mix, repmat(mixrand(:,i_mix), 1, length(p_Mixture))];
end
    
e = e12 .* mix;
e = (e(:,1:2) + e(:,3:4))'; % 2 * N_e00
clear e1 e2 e12


e = e ./ repmat(mean(e,2),1,N_e00);

e_TRUE = e(:, 1:n);
e_TRUE = e_TRUE ./ repmat(mean(e_TRUE,2),1,n);

subplot(2,2,1)
plot(e_TRUE(1,:),e_TRUE(2,:),'o')
title('e_{TRUE}','Color','red')
clear e;

h_TRUE = NaN * e_TRUE;
x_TRUE = NaN * e_TRUE;
h_TRUE(:,1) = [0.2;0.4];
x_TRUE(:,1) = h_TRUE(:,1) .* e_TRUE(:,1);
for t = 2:n
    h_TRUE(:,t) = o_GMEM_TRUE  + B_GMEM_TRUE * h_TRUE(:,t - 1) + A_GMEM_TRUE * x_TRUE(:,t - 1);
    x_TRUE(:,t) = h_TRUE(:,t) .* e_TRUE(:,t);
end

subplot(2,2,2)
plot(x_TRUE(1, :), x_TRUE(2, :), 'o')
title('x_{SIM}','Color','red')

subplot(2,2,3)
plot(x_TRUE(1, :))
title('x_{1}','Color','red')

subplot(2,2,4)
plot(x_TRUE(2, :))
title('x_{2}','Color','red')

%%
%%%%%%%%%%%%
% MLE init %
%%%%%%%%%%%%

Options  =  optimset('fmincon');
Options  =  optimset(Options , 'Display'     , 'off');
Options  =  optimset(Options , 'Diagnostics' , 'on');
Options  =  optimset(Options , 'LargeScale'  , 'on');
Options  =  optimset(Options , 'Algorithm', 'interior-point');

d = size(x_TRUE,1);

NParams = d + 2 * d^2 + (d^2 + d) / 2;

%%% Structure array that contains the specification of the conditional
%%% mean
Str.isdiagB = false;
Str.isdiagA = false;
Str.isdiagAneg = false;
Str.isdiagF = false;
Str.isdiagG = false;
Str.isdiagGneg = false;
Str.x_neg = [];
Str.x_lag = [];
Str.TimeSteps = [];
%%%%      

o_GMEM_0    = [0.2; 0.1];
B_GMEM_0    = [0.2  0.24 
               0.35 0.4];
A_GMEM_0    = [0.2  0.09
               0.1 0.28];
Sigma_Mat_GMEM_0  = [0.4  0.15
                     0.15 0.35]; 

[sd,Corr0] = cov2corr(Sigma_Mat_GMEM_0);  % starting CORRELATION MATRIX
pol = CorrMat2ThetaVec(Corr0);

% Initial parameters
Params_Initial = [o_GMEM_0' reshape(B_GMEM_0,1,d^2) reshape(A_GMEM_0,1,d^2) sd.^2 pol'];

%%% constraints 
ub_pol = triu (round(pi*1e6)*1e-6 * ones(d) + diag(round(pi*1e6)*1e-6*ones(d-1,1),1) , 1);
ub_pol(ub_pol == 0) = []; 

epsilon = 1e-6;
lb = -ones(length(Params_Initial),1)*Inf;
lb(end - length(ub_pol) - d + 1 : end) = epsilon;

ub = Params_Initial'*Inf;
ub(end - length(ub_pol) + 1 : end) = ub_pol';



%%
%%%%%%%%%%%%%%%%%
% ML Estimation %
%%%%%%%%%%%%%%%%%
tic;

x = x_TRUE(:,1:3000);

[Params_Opt,~,~,~,~,~,~] = fmincon('LogLikGvMEM', Params_Initial, [], [], [], [], lb, ub, [], Options, x, Str);
[I, ~] = IJMatrices('LogLikGvMEM_vec', Params_Opt', x, Str);


%%% Only B diagonal
o_GMEM_MLE     = Params_Opt(1:d)';
B_GMEM_MLE     = reshape(Params_Opt(d + 1 : d + d^2),d,d);
A_GMEM_MLE     = reshape(Params_Opt(d + d^2 + 1  : d + 2*d^2),d,d);


Sigma_GMEM_MLE = corr2cov(sqrt(Params_Opt(end - d*(d-1)*0.5 - d + 1 : end - d*(d-1)*0.5)),...
    ThetaVec2CorrMat(Params_Opt(end - d*(d-1)*0.5 + 1 : end)));

VC_MLE1 =  inv(I) / size(x,2);

toc
disp('    TRUE      MLE       sd')
disp([[o_GMEM_TRUE; reshape(B_GMEM_TRUE,d^2,1); reshape(A_GMEM_TRUE,d^2,1)],[o_GMEM_MLE; reshape(B_GMEM_MLE,d^2,1); reshape(A_GMEM_MLE,d^2,1)],sqrt(diag(VC_MLE1(1 : end - d - d*(d-1)*0.5 , 1 : end - d - d*(d-1)*0.5)))])
clear ub_pol A_GMEM_0 B_GMEM_0 Sigma_Mat_GMEM_0 pol Corr0 sd epsilon NParams ...
    Options ub lb Params_Initial I x_TRUE xneg_TRUE xlag_TRUE j d l Str

save(filename)