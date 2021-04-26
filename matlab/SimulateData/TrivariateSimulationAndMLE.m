%%%%%%%%%%%%%%%%%%%%
%%%  SIMULATION  %%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tri-dimensional data generated from:                       %%%
%%% x(t) = h(t) * e(t)                                         %%%
%%% e(t) ~ p * LogNormal(-diag(Sigma1)/2,Sigma1) +             %%%
%%%       (1-p) * LogNormal(-diag(Sigma2)/2,Sigma2)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear all
%%%%%%%%%%%%%%%%%%%%%%
%%% Simulated Data %%%
%%%%%%%%%%%%%%%%%%%%%%

filename = '../Data/TrivariateSimulation/Input/tmp.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
o_GMEM_TRUE = [0.35; 0.59; 0.43];
B_GMEM_TRUE = [0.36 0.07 0.18
               0.10 0.24 0.14
               0.01 0.10 0.41];
A_GMEM_TRUE = [0.21 0.14 0.04
               0.13 0.28 0.09
               0.07 0.08 0.30];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 5e4;

p_Mixture = [0.7 0.3];
N_e00 = 5e4;

Sigma1 = [0.4   0.3 0.2
          0.3  0.35 0.25
          0.2  0.25 0.3];

Sigma2 = [0.37  0.15 0.24
          0.15  0.39 0.18
          0.24  0.18 0.25];
      
e1 = exp(mvnrnd(-0.5*diag(Sigma1),Sigma1, N_e00)); % N_e00 * 2
e2 = exp(mvnrnd(-0.5*diag(Sigma2),Sigma2, N_e00)); % N_e00 * 2
e12 = [e1 e2];
mixrand = mnrnd(1, p_Mixture, N_e00);
mix = zeros(0,1);
for i_mix = 1:length(p_Mixture)
    mix = [mix, repmat(mixrand(:,i_mix),1, size(Sigma1,1))];
end
    
e = e12 .* mix;
e = (e(:,1:size(Sigma1,1)) + e(:,size(Sigma1,1)+1:end))'; % 2 * N_e00
clear e1 e2 e12


e = e ./ repmat(mean(e,2),1,N_e00);

e_TRUE = e(:, 1:n);
e_TRUE = e_TRUE ./ repmat(mean(e_TRUE,2),1,n);


%%%%%%%%%%%%%
%%% o,B,A %%%
%%%%%%%%%%%%%
h_TRUE = NaN * e_TRUE;
x_TRUE = NaN * e_TRUE;
h_TRUE(:,1) = [0.2;0.4;0.3];
x_TRUE(:,1) = h_TRUE(:,1) .* e_TRUE(:,1);
for t = 2:n
    h_TRUE(:,t) = o_GMEM_TRUE  + B_GMEM_TRUE * h_TRUE(:,t - 1) ...
        + A_GMEM_TRUE * x_TRUE(:,t - 1);
    x_TRUE(:,t) = h_TRUE(:,t) .* e_TRUE(:,t);
end

figure (1)
subplot(3,1,1)
plot(x_TRUE(1, :))
title('x_{1}','Color','red')

subplot(3,1,2)
plot(x_TRUE(2, :))
title('x_{2}','Color','red')

subplot(3,1,3)
plot(x_TRUE(3, :))
title('x_{3}','Color','red')


clear e e_TRUE h_TRUE i_mix mix mixrand n N_e00 t 

%%

%%%%%%%%%%%%%%%%%%%
% General Options %
%%%%%%%%%%%%%%%%%%%

Options  =  optimset('fmincon');
Options  =  optimset(Options , 'Display'     , 'on');
Options  =  optimset(Options , 'Diagnostics' , 'on');
Options  =  optimset(Options , 'LargeScale'  , 'on');
Options  =  optimset(Options , 'Algorithm', 'interior-point');
%Options  =  optimset(Options , 'Algorithm', 'active-set');
%Options  =  optimset(Options , 'Algorithm', 'sqp');
%Options  =  optimset(Options , 'Algorithm', 'trust-region-reflective'); %default
Options = optimset(Options, 'MaxFunEvals', 10000); %default 3000

o_GMEM_0 = [0.20; 0.50; 0.30];
B_GMEM_0 = [0.30  0.12 0.10
            0.04  0.23 0.08
            0.08  0.10 0.24];
A_GMEM_0 = [0.26 0.11 0.08
            0.17 0.27 0.10
            0.03 0.13 0.20];

Sigma_Mat_GMEM_0 = [0.25  0.20 0.10
                    0.20  0.25 0.15
                    0.10  0.15 0.15];

[sd,Corr0] = cov2corr(Sigma_Mat_GMEM_0);  % starting CORRELATION MATRIX
pol = CorrMat2ThetaVec(Corr0);

%%% o,B,A %%%
Params_Initial = [o_GMEM_0' reshape(B_GMEM_0,1,size(x_TRUE,1)^2) reshape(A_GMEM_0,1,size(x_TRUE,1)^2) sd.^2 pol'];

%%% constraints 
ub_pol = triu (round(pi*1e6)*1e-6 * ones(size(x_TRUE,1)) + diag(round(pi*1e6)*1e-6*ones(size(x_TRUE,1)-1,1),1) , 1);
ub_pol(ub_pol == 0) = []; 


epsilon = 1e-6;
lb = -ones(length(Params_Initial),1)*Inf;
lb(end - length(ub_pol) - size(x,1) + 1 : end) = epsilon;

ub = Params_Initial'*Inf;
ub(end - length(ub_pol) + 1 : end) = ub_pol';

clear ub_pol A_GMEM_0 B_GMEM_0 Aneg_GMEM_0 o_GMEM_0 Sigma_Mat_GMEM_0 pol Corr0 sd epsilon NParams

%%
%%%%%%%%%%%%%%%%%
% ML Estimation %
%%%%%%%%%%%%%%%%%
tic;

x = x_TRUE(:,1:3000);

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

[Params_Opt,~,~,~,~,~,~] = ...
   fmincon('LogLikGvMEM', Params_Initial, [], [], [], [], lb, ub, [], Options, x, Str);
[I, J] = IJMatrices('LogLikGvMEM_vec', Params_Opt', x, Str);

o_GMEM_MLE     = Params_Opt(1:size(x,1))';
B_GMEM_MLE     = reshape(Params_Opt(size(x,1) + 1 : size(x,1) + size(x,1)^2), size(x,1),size(x,1));
A_GMEM_MLE     = reshape(Params_Opt(size(x,1) + size(x,1)^2 + 1  : size(x,1) + 2*size(x,1)^2),size(x,1),size(x,1));

Sigma_GMEM_MLE = corr2cov(sqrt(Params_Opt(end - size(x,1)*(size(x,1)-1)*0.5 - size(x,1) + 1 : end - size(x,1)*(size(x,1)-1)*0.5)),...
    ThetaVec2CorrMat(Params_Opt(end - size(x,1)*(size(x,1)-1)*0.5 + 1 : end)));

VC_MLE1 =  inv(I) / size(x,2);
VC_MLE2 =  J \ I / J / size(x,2);
if min(min(VC_MLE2 == VC_MLE2')) ~= 1
    VC_MLE2 = 0.5*(VC_MLE2 + VC_MLE2');
end

eta_TRUE = [o_GMEM_TRUE', reshape(B_GMEM_TRUE,1,size(x,1)^2), reshape(A_GMEM_TRUE,1,size(x,1)^2)]';

disp('    TRUE      MLE       sd')
disp([eta_TRUE, Params_Opt(1:end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5)',sqrt(diag(VC_MLE1(1:end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5,1:end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5)))])
clear I J x_TRUE tElapsed Options ub lb Params_Initial ub_pol A_GMEM_0 B_GMEM_0 ...
      Aneg_GMEM_0 o_GMEM_0 Sigma_Mat_GMEM_0 pol Corr0 sd epsilon h_TRUE e  ...
      i_1 F_GMEM_0 xneg_TRUE  
save(filename)