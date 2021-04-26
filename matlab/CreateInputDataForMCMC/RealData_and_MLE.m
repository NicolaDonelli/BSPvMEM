%%%%%%%%%%%%%%%%%%%%
% Data preparation %
%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
format compact

load SandSData;
%%%  Shephard & Sheppard Data%%%%%%%%%%%%%
% The dataset contains, for each asset:  % 
% - Realized Kernel Variance,            %
% - Realized Variance                    %
% - Returns                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Transformation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We express the realized measures in annualized percentage terms:          %
% we multiply every realized measure by the number of trading days per year %
% and by 10.000                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 2:3:length(colheaders)
    A.Title = colheaders{i}(2:end-3);
    A.Date  = datenum(num2str(data(:, 1)), 'yyyymmdd');
    A.r     = data(:, i);
    A.Ar2   = data(:, i).^2 * 252 * 1e4;
    A.Ark2   = data(:, i + 2) * 252 * 1e4;
    DS_SS{(i - 2) / 3 + 1} = A;
end
clear A i data textdata colheaders

Names = {'DJIA',
'CAC 40',
'FTSE100',
'Spanish IBEX',
'Nasdaq 100',
'Italian MIBTEL',
'S&P 400 Midcap',
'Nikkei 250',
'Russell 3000',
'Russell 1000',
'Russell 2000',
'Milan MIB 30',
'German DAX',
'S & P TSE',
'SP500',
'MSCI Australia',
'MSCI Belgium',
'MSCI Brazil',
'MSCI Canada',
'MSCI Switzerland',
'MSCI Germany',
'MSCI Spain',
'MSCI France',
'MSCI UK',
'MSCI Italy',
'MSCI Japan',
'MSCI South Korea',
'MSCI Mexico',
'MSCI Netherlands',
'MSCI World',
'USD British Pound',
'USD Euro',
'USD Swiss Franc',
'USD Japanese Yen'};

% i_1 = 1; %DJIA
i_1 = 3; %FTSE100
% i_1 = 15; %SP500


rk2 = DS_SS{i_1}.Ark2; 
r2 = DS_SS{i_1}.Ar2;
r = DS_SS{i_1}.r;
Date = DS_SS{i_1}.Date;
INAN = isnan(rk2 .* r2);
rk2(max(INAN,r==0)) = [];
Date(max(INAN,r==0)) = [];
r2(max(INAN,r==0)) = [];
r(max(INAN,r==0)) = [];

figure(1)
rk2_ts = timeseries(rk2,datedisp(Date));
rk2_ts.Name = 'Relized Kernel Variance';
plot(rk2_ts)
xlim([rk2_ts.Time(1),rk2_ts.Time(end)])

figure(2)
rk_ts = timeseries(sqrt(rk2),datedisp(Date));
rk_ts.Name = 'Realized Kernel Volatility';
plot(rk_ts)
xlim([rk_ts.Time(1),rk_ts.Time(end)])

figure(3)
r2_ts = timeseries(r2,datedisp(Date));
r2_ts.Name = 'Squared Returns'; 
plot(r2_ts)
xlim([r2_ts.Time(1),r2_ts.Time(end)])

figure(4)
absr_ts = timeseries(sqrt(r2),datedisp(Date));
absr_ts.Name = 'Absolute Returns'; 
plot(absr_ts)
xlim([absr_ts.Time(1),absr_ts.Time(end)])

%%%%%%%%%%%%%%%%%%%%%%%%
%%% The data vectors %%%
%%%%%%%%%%%%%%%%%%%%%%%%
x = [sqrt(r2) sqrt(rk2)]'; % observations
x_neg = x .* repmat((r<=0)', size(x,1), 1); % asymmetric observations
x_lag = [zeros(size(x,1),1), x(:,1:end-1)]; % lagged observations

%%
%%%%%%%%%%%%%%%%%
% ML Estimation %
%%%%%%%%%%%%%%%%%

Options  =  optimset('fmincon');
Options  =  optimset(Options , 'Display'     , 'on');
Options  =  optimset(Options , 'Diagnostics' , 'on');
Options  =  optimset(Options , 'LargeScale'  , 'on');
Options  =  optimset(Options , 'Algorithm', 'interior-point');
%Options  =  optimset(Options , 'Algorithm', 'active-set');
%Options  =  optimset(Options , 'Algorithm', 'sqp');
%Options  =  optimset(Options , 'Algorithm', 'trust-region-reflective'); %default
Options = optimset(Options, 'MaxFunEvals', 10000); %default 3000

%%%% o, Bdiag, A [Modello 1, Cipollini, Engle, Gallo (2013) %%%%
% o_GMEM_0    = [0.01; 0.06];
% B_GMEM_0    = [0.10 ;0.04];
% A_GMEM_0    = [0.05 0.08
%               0.02 0.02];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, AnegDiag, Fdiag [Modello 2, Cipollini, Engle, Gallo(2013)]%%%%%%%%%%%
% o_GMEM_0    = [0.15; 0.43];
% B_GMEM_0    = [0.10; 0.41];
% A_GMEM_0    = [0.15 0.08
%               0.12 0.21];
% Aneg_GMEM_0 = [0.08; 0.17];
% F_GMEM_0 = [0.10; 0.05];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, AnegDiag, F [Modello 3, Cipollini, Engle, Gallo(2013)]%%%%%%%%%%%
% o_GMEM_0    = [0.15; 0.43];
% B_GMEM_0    = [0.10; 0.41];
% A_GMEM_0    = [0.15 0.08
%               0.12 0.21];
% Aneg_GMEM_0 = [0.08; 0.17];
% F_GMEM_0 = [0.10 0.03
%            0.02 0.05];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, Aneg, F [Modello 4]%%%%%%%%%%%
o_GMEM_0    = [0.15; 0.43];
B_GMEM_0    = [0.10; 0.41];
A_GMEM_0    = [0.15 0.08
              0.12 0.21];
Aneg_GMEM_0 = [0.08 0.04
               0.07 0.17];
F_GMEM_0 = [0.10 0.03
           0.02 0.05];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sigma_Mat_GMEM_0 = [0.25 0.20
                    0.20  0.25];           

[sd,Corr0] = cov2corr(Sigma_Mat_GMEM_0);  % starting CORRELATION MATRIX
pol = CorrMat2ThetaVec(Corr0);

%%%% Modello 1: o, Bdiag, A %%%%
% Params_Initial = [o_GMEM_0' B_GMEM_0' reshape(A_GMEM_0,1,size(x,1)^2) sd.^2 pol'];

%%%% Modello 2: o, Bdiag, A, AnegDiag, Fdiag %%%%
% Params_Initial = [o_GMEM_0' B_GMEM_0' reshape(A_GMEM_0,1,size(x,1)^2) Aneg_GMEM_0' F_GMEM_0' sd.^2 pol'];

%%%% Modello 3: o, Bdiag, A, AnegDiag, F %%%%
% Params_Initial = [o_GMEM_0' B_GMEM_0' reshape(A_GMEM_0,1,size(x,1)^2) Aneg_GMEM_0' reshape(F_GMEM_0,1,size(x,1)^2) sd.^2 pol'];

%%%% Modello 4: o, Bdiag, A, Aneg, F %%%%
Params_Initial = [o_GMEM_0' B_GMEM_0' reshape(A_GMEM_0,1,size(x,1)^2) reshape(Aneg_GMEM_0,1,size(x,1)^2) reshape(F_GMEM_0,1,size(x,1)^2) sd.^2 pol'];

%%% Constraints
ub_pol = triu (round(pi*1e6)*1e-6 * ones(size(x,1)) + diag(round(pi*1e6)*1e-6*ones(size(x,1)-1,1),1) , 1);
ub_pol(ub_pol == 0) = []; 

epsilon = 1e-6;
lb = -ones(length(Params_Initial),1)*Inf;
lb(end - length(ub_pol) - size(x,1) + 1 : end) = epsilon;

ub = Params_Initial'*Inf;
ub(end - length(ub_pol) + 1 : end) = ub_pol';

%%% Structure array that contains the specification of the conditional
%%% mean
Str.isdiagB = true;
Str.isdiagA = false;
Str.isdiagAneg =  false;
Str.isdiagF = false;
Str.isdiagG = false;
Str.isdiagGneg = false;
Str.x_neg = x_neg;
Str.x_lag = x_lag;
Str.TimeSteps = [];

[Params_Opt,~,~,~,~,~,~] = ...
   fmincon('LogLikGvMEM', Params_Initial, [], [], [], [], lb, ub, [], Options, x, Str);
[I, ~] = IJMatrices('LogLikGvMEM_vec', Params_Opt', x, Str);

%%%% o, Bdiag, A [Modello 1, Cipollini, Engle, Gallo (2013) %%%%%%%%%%%%%%
% o_GMEM_MLE     = Params_Opt(1:size(x,1))';
% B_GMEM_MLE     = Params_Opt(size(x,1) + 1 : 2*size(x,1))';
% A_GMEM_MLE     = reshape(Params_Opt(2*size(x,1) + 1  : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, AnegDiag, Fdiag [Modello 2, Cipollini, Engle, Gallo(2013)]%%%%%%%%%%%
% o_GMEM_MLE     = Params_Opt(1:size(x,1))';
% B_GMEM_MLE     = Params_Opt(size(x,1) + 1 : 2*size(x,1))';
% A_GMEM_MLE     = reshape(Params_Opt(2*size(x,1) + 1  : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1));
% Aneg_GMEM_MLE  = Params_Opt(2*size(x,1) + size(x,1)^2 + 1  : 3*size(x,1) + size(x,1)^2)';
% F_GMEM_MLE     = Params_Opt(3*size(x,1) + size(x,1)^2 + 1  : 4*size(x,1) + size(x,1)^2)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, AnegDiag, F [Modello 3, Cipollini, Engle, Gallo(2013)]%%%%%%%%%%%
% o_GMEM_MLE     = Params_Opt(1:size(x,1))';
% B_GMEM_MLE     = Params_Opt(size(x,1) + 1 : 2*size(x,1))';
% A_GMEM_MLE     = reshape(Params_Opt(2*size(x,1) + 1  : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1));
% Aneg_GMEM_MLE  = Params_Opt(2*size(x,1) + size(x,1)^2 + 1  : 3*size(x,1) + size(x,1)^2)';
% F_GMEM_MLE     = reshape(Params_Opt(3*size(x,1) + size(x,1)^2 + 1  : 3*size(x,1) + 2*size(x,1)^2), size(x,1), size(x,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% o, Bdiag, A, AnegDiag, F [Modello 4]%%%%%%%%%%%
o_GMEM_MLE     = Params_Opt(1:size(x,1))';
B_GMEM_MLE     = Params_Opt(size(x,1) + 1 : 2*size(x,1))';
A_GMEM_MLE     = reshape(Params_Opt(2*size(x,1) + 1  : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1));
Aneg_GMEM_MLE  = reshape(Params_Opt(2*size(x,1) + size(x,1)^2 + 1  : 2*size(x,1) + 2*size(x,1)^2),size(x,1),size(x,1));
F_GMEM_MLE     = reshape(Params_Opt(2*size(x,1) + 2*size(x,1)^2 + 1  : 2*size(x,1) + 3*size(x,1)^2), size(x,1), size(x,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sigma_GMEM_MLE = corr2cov(sqrt(Params_Opt(end - size(x,1)*(size(x,1)-1)*0.5 - size(x,1) + 1 : end - size(x,1)*(size(x,1)-1)*0.5)),...
    ThetaVec2CorrMat(Params_Opt(end - size(x,1)*(size(x,1)-1)*0.5 + 1 : end)));

VC_MLE1 =  inv(I) / size(x,2);

disp('    MLE       sd')
disp([Params_Opt',sqrt(diag(VC_MLE1))])
clear tElapsed Options ub lb Params_Initial I ub_pol A_GMEM_0 B_GMEM_0 ...
      Aneg_GMEM_0 o_GMEM_0 Sigma_Mat_GMEM_0 pol Corr0 sd epsilon rv2_ts rv2 ...
      rk2 rk_ts r2 r2_ts r absr absr_ts DS_SS Names INAN i_1 F_GMEM_0

save RealData&MLE(FTSE100)_o_Bdiag_A_Aneg_F

h_MLE = vMEMh(x,Params_Opt(1:end-3)',mean(x,2),Str);
disp('min(h_MLE)  max(h_MLE)')
disp([min(min(h_MLE)), max(max(h_MLE))])