%%MCMC
clear all

%clear all
clf 
close all
clc
%profile on
addpath('../Utilities')

%%%%% DATA %%%

%load('../../data/BivariateSimulation/Input/Simulation_Bivariate_MLEstimates_3000_mixture.mat')
%load('../../data/TrivariateSimulation/Input/Simulation_Trivariate_MLEstimates_3000_oBA_3.mat')
load('../../data/RealData/Input/RealData&MLE(SP500)_o_Bdiag_A_1.mat')
%load('../../data/RealData/Input/RealData&MLE(FTSE100)_o_Bdiag_A_1.mat')
%load('../../data/RealData/Input/RealData&MLE(DJIA)_o_Bdiag_A.mat')
%%%%%%%%%%%

%%%%%%%
%%% When you change the model you need to remember to change:
%%% - Str
%%% - eta_TRUE
%%% - final plots
%%%%%%%

%%% Structure array that contains the specification of the conditional
%%% mean
Str.isdiagB = true;
Str.isdiagA = false;
Str.isdiagAneg = false;
Str.isdiagF = false;
Str.isdiagG = false;
Str.isdiagGneg = false;
Str.x_neg = [];
Str.x_lag = [];
Str.TimeSteps = [];
%%%%

T = size(x, 2);

% eta_TRUE = [o_GMEM_TRUE; reshape(B_GMEM_TRUE,size(x,1)^2,1); reshape(A_GMEM_TRUE,size(x,1)^2,1)];

eta_MLE = Params_Opt(1:end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5)';
h_MLE = vMEMh(x, eta_MLE, mean(x,2), Str);


PositiveValues = false;
seed = rng;
%rng(seed)

y = x./h_MLE;
dim_y = size(y, 1);
y_log = log(y); 


VC_BurnIn = VC_MLE1(1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5 ,...
    1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5);
%VC_BurnIn = VC_MLE2(1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5 ,...
%    1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5);


Scale1 = 1;
Scale2 = sqrt(21);
p_mixture = 1;
LAMBDA = VC_BurnIn;
eps2 = 1e-6;

% NTot = 150e3;
% NBurnIn = 1e4;
% NMCMC0  = 2e4;
% NMCMC1  = NTot - NBurnIn - NMCMC0;
% NSTEPS = 1e4;

NTot = 100e3;
NBurnIn = 5e3;
NMCMC0  = 5e3;
NMCMC1  = NTot - NBurnIn - NMCMC0;
NSTEPS = 1e4;


if (mod(NBurnIn + NMCMC0, NSTEPS) ~= 0)
    error('NBurnIn + NMCMC0 must be a multiple NSTEPS')
end

% VC of the Truncated Normal prior on the vector of parameters, eta:
VC_prior_eta = 20 * diag(diag(VC_MLE1(1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5 ,...
    1 : end - size(x,1) - size(x,1)*(size(x,1)-1)*0.5)));
Mean_prior_eta = zeros(size(eta_MLE));

% Hyperparameters N-W Disribution
NW_a = dim_y + 10;
NW_Winv = 1 * diag(var(y_log, 0, 2));
NW_W = inv(NW_Winv);
NW_mu = mean(y_log, 2);
NW_n0 = 1;
eps_mbar = 1e-6;

% Hyperparameters: 
kappa = 1.5;
c = 1; %DP's concentration parameter (fixed)
xi = (c / (kappa * (1 + c))) .^ (1:1e3)' * 1/c;

% Initialization of d
N0_Components = 3;
d  = floor(N0_Components * rand(T, 1)) + 1; 

% Initialization of eta
eta = eta_MLE;
LengthEta = length(eta);

% Pre-allocation of storage matrices
ALL_PROB_eta = zeros(NBurnIn + NMCMC0 + NMCMC1,1);
%MC = cell(1,NBurnIn + NMCMC0 + NMCMC1);
%eta_matrix = NaN * zeros(NBurnIn + NMCMC0 + NMCMC1, length(eta));
%eta_Mapped_MATRIX = zeros(NBurnIn + NMCMC0 + NMCMC1, length(eta));

%%%% Saving every NSTEPS
MC = cell(1,NSTEPS);
eta_matrix = NaN * zeros(NSTEPS, LengthEta);
eta_Mapped_MATRIX = zeros(NSTEPS, LengthEta);

% 1) Sampling u:[required d]
u = xi(d) .* rand(T, 1);
N = floor(log(min(u * c)) / log((c / (kappa * (1 + c)))));
% vector of nj values
n_vec  = sum(repmat(d, 1, N) == repmat(1:N, T, 1))';
n_vec2 = sum(repmat(d, 1, N) >  repmat(1:N, T, 1))';

% 2) Sampling v : [required: d through n_vec and n_vec2]
v = betarnd(1 + n_vec, c + n_vec2);
w = zeros(N, 1);
for i_w = 1:N
    w(i_w) = v(i_w) * prod(1 - v(1:i_w-1));
end

% Initialization of mu and Tau
mu  = NaN * zeros(dim_y, N);
Tau = NaN * zeros(dim_y, dim_y, N);
Sigma = NaN * zeros(dim_y, dim_y, N);
for i_muTau = 1:N
    [Tau_i, mu_i, Sigma_i] = normwishrnd(NW_a, NW_W, NW_mu, NW_n0);
    mu(:, i_muTau) = mu_i;
    Tau(:, :, i_muTau) = Tau_i;
    Sigma(:, :, i_muTau) = Sigma_i;
end

% 3) Sampling [mu, Tau]
for j_muTau = 1:N
    if (n_vec(j_muTau) == 0)
        [Tau_j, mu_j, Sigma_j] = normwishrnd(NW_a, NW_W, NW_mu, NW_n0);
        mu(:, j_muTau) = mu_j;
        Tau(:, :, j_muTau) = Tau_j;
        Sigma(:, :, j_muTau) = Sigma_j;
    else
        nj   = n_vec(j_muTau);
        y_j_muTau   = y_log(:, d == j_muTau);
        y_j_muTau_m = mean(y_j_muTau, 2);
        y_j_muTau_S = cov(y_j_muTau') * (size(y_j_muTau, 2) - 1);
        % Full Conditional Parameters
        NW_a_j  = NW_a + nj;
        NW_W_j  = inv(NW_Winv + y_j_muTau_S ...
                         + (nj * NW_n0) / (nj + NW_n0) * (y_j_muTau_m - NW_mu) * (y_j_muTau_m - NW_mu)');
        NW_mu_j = (NW_n0 * NW_mu + nj * y_j_muTau_m) / (NW_n0 + nj);
        NW_n0_j = NW_n0 + nj;
        % Generate from Full Conditional
        [Tau_j_new, mu_j_new, Sigma_j_new] = normwishrnd(NW_a_j, NW_W_j, NW_mu_j, NW_n0_j);
        Tau(:, :, j_muTau) = Tau_j_new;
        mu(:, j_muTau)     = mu_j_new;
        Sigma(:, :, j_muTau) = Sigma_j_new;        
    end
end

% calculating m_bar, necessary for the post-processing transformation

w_extended  = zeros(1e3, 1);
mu_extended = zeros(dim_y,1e3);
Sigma_extended = zeros(dim_y,1e3);
w_extended(1:N) = w;    
mu_extended(:,1:N) = mu;
Sigma_extended(:,1:N) = diagarray(Sigma(:,:,1:N));
i_wex = N;
while (i_wex < length(w_extended) && sum(w_extended) < 1-eps_mbar)
    [~, mu_temp,Sigma_temp] = normwishrnd(NW_a, NW_W, NW_mu, NW_n0);
    i_wex = i_wex + 1;
    v_ex = betarnd(1, c);
    w_extended(i_wex) = v_ex * (1 - sum(w_extended(1:i_wex-1)));      
    mu_extended(:, i_wex) = mu_temp;
    Sigma_extended(:,i_wex) = diag(Sigma_temp);
end
i_wex = find(cumsum(w_extended) > 1-eps_mbar, 1);
w_extended = w_extended(1:i_wex);
mu_extended = mu_extended(:,1:i_wex);
Sigma_extended = Sigma_extended(:,1:i_wex);
mbar = exp(mu_extended + 0.5 * Sigma_extended) * w_extended;

diagSigma = diagarray(Sigma(:,:,1:N));
h_1 = mean(x,2)./ mean(exp(mu(:,d) + 0.5*diagSigma(:,d)),2);
h = vMEMh(x, eta, h_1, Str);
y = x ./ h;
y_log = log(y);

% 4) Sampling d [required: u, v(w), M0, mu]
p01 = (repmat(xi(1:N), 1, T) > repmat(u', N, 1)) .* repmat(w, 1, T) ./ repmat(xi(1:N), 1, T);
p02 = NaN * zeros(N, T);
for i = 1:N
    p02(i, :) = mvnpdf(y_log',mu(:, i)', Sigma(:, :, i))' ./ prod(y);
end
p0  = p01 .* p02;
p = p0 ./ repmat(sum(p0), N, 1); % array of probability weights for the possible values of d
q = cumsum(p);
% sampling d_t using the inverse p.d. sampling method (with a discrete p.d.)
d = 1 + sum(repmat(rand(1, T), N, 1) > q)'; 

h_1 = mean(x,2)./ mean(exp(mu(:,d) + 0.5*diagSigma(:,d)),2);
PostProc = PostProcessing(mbar, LengthEta, Str.isdiagB); 

% 5) Sampling eta = vec(o, B, A) 
eta_prop = mvnrnd(eta, VC_BurnIn)'; 

if min(eta_prop) >= 0
    [LogPostCurr, h] = vMEMFullCond(eta, d, mu, Sigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, Str);
    [LogPostProp, h_Prop] = vMEMFullCond(eta_prop, d, mu, Sigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, Str);
    prob_acc = min(1, exp(LogPostProp - LogPostCurr));
else
    prob_acc = 0;
end
ALL_PROB_eta(1) = prob_acc;
if rand < prob_acc
    eta = eta_prop;
    h   = h_Prop;
end

eta_Mapped = eta .* PostProc;
eta_Mapped_MATRIX(1, :) = eta_Mapped'; 
eta_MEAN = eta_Mapped;

y = x ./ h;
y_log = log(y);

MC{1}.N = N;
MC{1}.w = w;
MC{1}.mu = mu;
MC{1}.Sigma = Sigma;
MC{1}.mbar = mbar;
MC{1}.d = d;
MC{1}.eta_prop = eta_prop;
MC{1}.h_1 = h_1;
eta_matrix(1, :) = eta';

u_MH_ETA = rand(NBurnIn + NMCMC0 + NMCMC1, 1);

t_start = tic;
for t = 2:NBurnIn + NMCMC0 + NMCMC1

    % 1) Sampling u:[required d]
    u = xi(d) .* rand(T, 1);
    N = floor(log(min(u * c)) / log((c / (kappa * (1 + c)))));
    % vector of nj values
    n_vec  = sum(repmat(d, 1, N) == repmat(1:N, T, 1))';
    n_vec2 = sum(repmat(d, 1, N) >  repmat(1:N, T, 1))';

    % 2) Sampling w
    v = betarnd(1 + n_vec, c + n_vec2);
    w = zeros(N, 1);
    for i_w = 1:N
        w(i_w) = v(i_w) * prod(1 - v(1:i_w-1));
    end

    % 3) Sampling mu, Tau
    mu  = NaN * zeros(dim_y, N);
    Tau = NaN * zeros(dim_y, dim_y, N);
    Sigma = NaN * zeros(dim_y, dim_y, N);
    for j_muTau = 1:N
        if (n_vec(j_muTau) == 0)
            [Tau_j, mu_j, Sigma_j] = normwishrnd(NW_a, NW_W, NW_mu, NW_n0);
            mu(:, j_muTau) = mu_j;
            Tau(:, :, j_muTau) = Tau_j;
            Sigma(:, :, j_muTau) = Sigma_j;
        else
            nj   = n_vec(j_muTau);
            y_j_muTau   = y_log(:, d == j_muTau);
            y_j_muTau_m = mean(y_j_muTau, 2);
            y_j_muTau_S = cov(y_j_muTau') * (size(y_j_muTau, 2) - 1);
            % Full Conditional Parameters
            NW_a_j  = NW_a + nj;
            NW_W_j  = inv(NW_Winv + y_j_muTau_S ...
                     + (nj * NW_n0) / (nj + NW_n0) * (y_j_muTau_m - NW_mu) * (y_j_muTau_m - NW_mu)');
            NW_mu_j = (NW_n0 * NW_mu + nj * y_j_muTau_m) / (NW_n0 + nj);
            NW_n0_j = NW_n0 + nj;
            % Generate from Full Conditional
            [Tau_j_new, mu_j_new, Sigma_j_new] = normwishrnd(NW_a_j, NW_W_j, NW_mu_j, NW_n0_j);
            Tau(:, :, j_muTau) = Tau_j_new;
            mu(:, j_muTau)     = mu_j_new;
            Sigma(:, :, j_muTau) = Sigma_j_new;        
        end
    end
    
    % calculating m_bar, necessary for the post-processing transformation
    w_extended  = zeros(1e3, 1);
    mu_extended = zeros(dim_y,1e3);
    Sigma_extended = zeros(dim_y,1e3);
    w_extended(1:length(w)) = w;    
    mu_extended(:,1:size(mu,2)) = mu;
    Sigma_extended(:,1:N) = diagarray(Sigma(:,:,1:N));
    i_wex = length(w);
    while (i_wex < length(w_extended) && sum(w_extended) < 1-eps_mbar)
        [~, mu_temp,Sigma_temp] = normwishrnd(NW_a, NW_W, NW_mu, NW_n0);
        i_wex = i_wex + 1;
        v_ex = betarnd(1, c);
        w_extended(i_wex) = v_ex * (1 - sum(w_extended(1:i_wex-1)));      
        mu_extended(:, i_wex) = mu_temp;
        Sigma_extended(:,i_wex) = diag(Sigma_temp);
    end
    i_wex = find(cumsum(w_extended) > 1-eps_mbar, 1);
    w_extended = w_extended(1:i_wex);
    mu_extended = mu_extended(:,1:i_wex);
    Sigma_extended = Sigma_extended(:,1:i_wex);
    mbar = exp(mu_extended + 0.5 * Sigma_extended) * w_extended;
    
    diagSigma = diagarray(Sigma(:,:,1:N));    
    h_1 = mean(x,2)./ mean(exp(mu(:,d) + 0.5*diagSigma(:,d)),2);
    h = vMEMh(x, eta, h_1, Str);
    y = x ./ h;
    y_log = log(y);
    
    % 4) Sampling d [required: u, w, M0, mu, Sigma]
    p01 = (repmat(xi(1:N), 1, T) > repmat(u', N, 1)) .* repmat(w, 1, T) ./ repmat(xi(1:N), 1, T);
    p02 = NaN * zeros(N, T);
    for i = 1:N
        p02(i, :) = mvnpdf(y_log',mu(:, i)', Sigma(:, :, i))' ./ prod(y);
    end
    p0  = p01 .* p02;
    p = p0 ./ repmat(sum(p0), N, 1);
    q = cumsum(p);
    % sampling d_t using the inverse p.d. sampling method (with a discrete p.d.)
    d = 1 + sum(repmat(rand(1, T), N, 1) > q)'; 
    
    h_1 = mean(x,2)./ mean(exp(mu(:,d) + 0.5*diagSigma(:,d)),2);
    PostProc = PostProcessing(mbar, LengthEta, Str.isdiagB); 
    
    % 5) Sampling eta (RW-MH)
    
    % In the first NBurnIn + NMCMC0 iterations we use a Normal proposal with
    % VC_BurnIn = VC_MLE1(parametri)
    % In the further NMCMC1 iteratioms we use an adaptive Normal poposal with
    % VC = EmpVC of all the past mapped (identifiable) params .* inverse-mapping transf.
    
    if t == (NBurnIn + NMCMC0)
        eta_Mapped_MATRIX_TEMP = NaN * zeros(NBurnIn + NMCMC0 - 1,LengthEta);
        for j = 1 : (NBurnIn + NMCMC0)/NSTEPS - 1
            filenameLoad = ['../../data/Temp/Output_' num2str(j*NSTEPS)];
            TEMP = load(filenameLoad);
            eta_Mapped_MATRIX_TEMP((j-1)*NSTEPS + 1 : j*NSTEPS , :) = TEMP.eta_Mapped_MATRIX;
        end
        eta_Mapped_MATRIX_TEMP(j*NSTEPS + 1 : end , :) = eta_Mapped_MATRIX(1:end-1,:);
        Stm1 =  cov(eta_Mapped_MATRIX_TEMP(NBurnIn+1:t-1, :));
        mtm1 = mean(eta_Mapped_MATRIX_TEMP(NBurnIn+1:t-1, :))';
        mtm2 = mean(eta_Mapped_MATRIX_TEMP(NBurnIn+1:t-2, :))';
        clear TEMP eta_Mapped_MATRIX_TEMP
    end
    if t <= NBurnIn + NMCMC0
        LAMBDA = VC_BurnIn;
    else
        Stm2 = Stm1;
        xtm1 = eta_Mapped;
        mtm2 = mtm1;  
        mtm1 = (t - NBurnIn - 2) / (t - NBurnIn - 1) * mtm2 + 1 / (t - NBurnIn - 1) * xtm1;
        Stm1 =   (t - NBurnIn - 3) / (t - NBurnIn - 2) * Stm2 ...
               + mtm2 * mtm2' ...
               - (t - NBurnIn - 1) / (t - NBurnIn - 2) * (mtm1 * mtm1') ...
               + 1 / (t - NBurnIn - 2) * (xtm1 * xtm1');
        Stm1 = (Stm1 + Stm1') / 2;
        if (min(eig(Stm1)) < 0)
            Stm1 = Stm2;
        end
        LAMBDA = Stm1 ./ (PostProc * PostProc') + eps2 * eye(LengthEta);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%% Mixture Proposal %%%
    %%%%%%%%%%%%%%%%%%%%%%%%
    if rand < p_mixture
        eta_prop = mvnrnd(eta, LAMBDA * (Scale1)^2 / LengthEta)';
    else
        eta_prop = mvnrnd(eta, LAMBDA * (Scale2)^2 / LengthEta)';
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Standard Propposal %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %eta_prop = mvnrnd(eta, LAMBDA * (Scale)^2 / LengthEta)';
    
    [LnPostCurr, h     ] = vMEMFullCond(eta, d, mu, Sigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, Str);
    [LnPostProp, h_Prop] = vMEMFullCond(eta_prop, d, mu, Sigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, Str);
    prob_acc = min(1, exp(LnPostProp - LnPostCurr));
    
    ALL_PROB_eta(t) = prob_acc;
    if u_MH_ETA(t) < prob_acc
        eta = eta_prop;
        h  = h_Prop;
    end
    
    eta_Mapped = eta .* PostProc; 
    %if t < NBurnIn + NMCMC0
    %    eta_Mapped_MATRIX(t, :) = eta_Mapped';
    %end
    
    y = x ./ h;
    y_log = log(y);
    eta_MEAN = (eta_Mapped + (t-1) * eta_MEAN) / t;
    
    MC{mod(t-1,NSTEPS) + 1}.N = N;
    MC{mod(t-1,NSTEPS) + 1}.w = w;
    MC{mod(t-1,NSTEPS) + 1}.mu = mu;
    MC{mod(t-1,NSTEPS) + 1}.Sigma = Sigma;
    MC{mod(t-1,NSTEPS) + 1}.mbar = mbar;
    MC{mod(t-1,NSTEPS) + 1}.d = d;
    MC{mod(t-1,NSTEPS) + 1}.eta_prop = eta_prop;
    MC{mod(t-1,NSTEPS) + 1}.h_1 = h_1;
    MC{mod(t-1,NSTEPS) + 1}.seed = rng;
    MC{mod(t-1,NSTEPS) + 1}.Time = toc(t_start);
    eta_matrix(mod(t-1,NSTEPS) + 1, :) = eta';
    eta_Mapped_MATRIX(mod(t-1,NSTEPS) + 1, :) = eta_Mapped';
    
    if mod(t,NSTEPS) == 0
        filename = ['../../data/Temp/Output_',num2str(t)];
        save(filename,'eta_Mapped_MATRIX','MC','eta_matrix');
    end
    
    %PLOTS
    if (mod(t, NSTEPS) == 0)
        clc
        Time_Elapsed = toc(t_start);
        Time_Remained = Time_Elapsed / t * (NBurnIn + NMCMC0 + NMCMC1 - t);
        disp('************************************************')
        disp(['Simulation ends at: ' datestr(now + Time_Remained / 60 / 60 / 24)])
        disp('************************************************')
        [t t/(NBurnIn + NMCMC0 + NMCMC1)*100]
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         disp('    ML Est.   MCMC      TRUE')
%         disp([eta_MLE eta_MEAN eta_TRUE])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        disp('    ML Est.   MCMC')
        disp([eta_MLE eta_MEAN])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        disp('    mbar')
        disp(mbar)
        disp('    Total A.R.')
        disp(mean(ALL_PROB_eta(1:t)))
        if (t>NBurnIn+NMCMC0)
            disp('    Adaptive A.R.')
            disp(mean(ALL_PROB_eta(NBurnIn+NMCMC0:t)))
        end
        [length(w) length(w_extended)
         sum(w)    sum(w_extended)]
        
        % We need a plot for every parameter to see how it varies through
        % the iterations:
        
        figure(1)
        for i = 1:size(x,1)
            subplot(size(x,1),1,i)
            plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX(:, i));
            xlim([(max(1, t - NSTEPS + 1)) t])
        end

        figure(2)
        for i = 1:size(x,1)
            subplot(size(x,1),1,i)
            plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX(:, size(x,1) + i));
            xlim([(max(1, t - NSTEPS + 1)) t])
        end

        figure(3)
        for i = 1:size(x,1)^2
            subplot(size(x,1)^2,1,i)
            plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX(:, 2*size(x,1) + i));
            xlim([(max(1, t - NSTEPS + 1)) t])
        end
        
        %figure(4)
        %for i = 1:size(x,1)^2
        %    subplot(size(x,1)^2,1,i)
        %    plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX(:, size(x,1) + 2*size(x,1)^2 + i));
        %    xlim([(max(1, t - NSTEPS + 1)) t])
        %end
        
        pause(0.01)
    end
end

Time_Elapsed = toc(t_start)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The simulation is finished:         %%%
%%% execute Graphs.m to get the graphs  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
