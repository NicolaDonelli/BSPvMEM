%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set the name to be used as suffix/prefix for output files %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path_to_pars = '../../data/BivariateSimulation/Output/EXAMPLE_PAR.mat';
path_to_workspace = '../../data/BivariateSimulation/Output/EXAMPLE_WORKSPACE.mat';
path_to_figures = '../../data/BivariateSimulation/Images/EXAMPLE_PREFIX';
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Merging data stored in different files  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Useful notational conventions
dim_x = size(x,1);
Burn_In = NBurnIn+NMCMC0;

if ~exist('NTot','var')
    NTot = NBurnIn + NMCMC0 + NMCMC1;
end
eta_Mapped_MATRIX_tot = NaN * zeros(NBurnIn+NMCMC0+NMCMC1,length(eta));
eta_matrix_tot = NaN * zeros(NBurnIn+NMCMC0+NMCMC1,length(eta));
MC_tot = cell(NBurnIn+NMCMC0+NMCMC1,1);
for j = 1 : (NBurnIn+NMCMC0+NMCMC1)/NSTEPS
    filenameLoad = ['../../data/Temp/Output_' num2str(j*NSTEPS)];
    load(filenameLoad)
    eta_Mapped_MATRIX_tot((j-1)*NSTEPS + 1 : (j)*NSTEPS , :) = eta_Mapped_MATRIX;
    eta_matrix_tot ((j-1)*NSTEPS + 1 : (j)*NSTEPS , :) = eta_matrix;
    MC_tot((j-1)*NSTEPS + 1 : (j)*NSTEPS , 1) = MC;
end
clear eta_Mapped_MATRIX eta_matrix MC
eta_Mapped_MATRIX = eta_Mapped_MATRIX_tot;
eta_matrix = eta_matrix_tot;
MC = MC_tot;
clear MC_tot eta_Mapped_MATRIX_tot eta_matrix_tot

save(path_to_pars,'eta_Mapped_MATRIX')
%%
%%% If there are some empty cells due to the merging process:
MC = MC(~cellfun('isempty',MC));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Check the specification of the conditional mean %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('Str','var')
    if size(B_GMEM_MLE,1) ~= size(B_GMEM_MLE,2)
        Str.isdiagB = true;
    else
        Str.isdiagB = false;
    end
    
    if size(A_GMEM_MLE,1) ~= size(A_GMEM_MLE,2)
        Str.isdiagA = true;
    else
        Str.isdiagA = false;
    end
    
    if exist('Aneg_GMEM_MLE','var')
        if exist('x_neg','var')
            Str.x_neg = x_neg;
        else
            warning('There is Aneg but there is not x_neg')
        end
        if size(Aneg_GMEM_MLE,1) ~= size(Aneg_GMEM_MLE,2)
            Str.isdiagAneg = true;
        else
            Str.isdiagAneg = false;
        end
    else
        Str.isdiagAneg = false;
        Str.x_neg = [];
    end
    
    if exist('F_GMEM_MLE','var')
        if exist('x_lag','var')
            Str.x_lag = x_lag;
        else
            warning('There is F but there is not x_lag')
        end
        if size(F_GMEM_MLE,1) ~= size(F_GMEM_MLE,2)
            Str.isdiagF = true;
        else
            Str.isdiagF = false;
        end
    else
        Str.isdiagF = false;
        Str.x_lag = [];
    end
    
    if exist('G_GMEM_MLE','var') && size(G_GMEM_MLE,1) ~= size(G_GMEM_MLE,2)
        Str.isdiagG = true;
    else
        Str.isdiagG = false;
    end
    
    if exist('Gneg_GMEM_MLE','var') && size(Gneg_GMEM_MLE,1) ~= size(Gneg_GMEM_MLE,2)
        Str.isdiagGneg = true;
    else
        Str.isdiagGneg = false;
    end
    
    if exist('TimeSteps','var')
        Str.TimeSteps = TimeSteps;
    else
        Str.TimeSteps = [];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Verify if there exists true parameters:                %%%
%%%% if there is not the first vector, then there is none!  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('o_GMEM_TRUE','var') == 0
    o_GMEM_TRUE = []; B_GMEM_TRUE = []; A_GMEM_TRUE = []; Aneg_GMEM_TRUE = [];
    F_GMEM_TRUE = []; K_GMEM_TRUE = []; G_GMEM_TRUE = []; Gneg_GMEM_TRUE = [];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Transform into vectors any true diagonal matrices %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Str.isdiagB == 1 && isvector(B_GMEM_TRUE) == 0
    B_GMEM_TRUE = diag(B_GMEM_TRUE);
end
if Str.isdiagA == 1 && isvector(A_GMEM_TRUE) == 0
    A_GMEM_TRUE = diag(A_GMEM_TRUE);
end
if Str.isdiagA == 1 && isvector(Aneg_GMEM_TRUE) == 0
    Aneg_GMEM_TRUE = diag(Aneg_GMEM_TRUE);
end

%%%% Verify if there are asymmetric components 
if isempty(Str.x_neg)
    Aneg_GMEM_MLE = []; Aneg_GMEM_TRUE = []; Gneg_GMEM_MLE = []; Gneg_GMEM_TRUE = [];
end

%%%% Verify if there are doubly-lagged components
if isempty(Str.x_lag)
    F_GMEM_MLE = []; F_GMEM_TRUE = [];
end

%%%% Verify if there are different time periods
if isempty(Str.TimeSteps) == 0
    TI = length(Str.TimeSteps) - 1;
else
    TI = 0;
    K_GMEM_MLE = []; K_GMEM_TRUE = []; G_GMEM_MLE = []; G_GMEM_TRUE = [];
    Gneg_GMEM_MLE = []; Gneg_GMEM_TRUE = [];
end

%%
%%%%%%%%%%%%%%%%%%%%%
%%%% Mapped Plot %%%%
%%%%%%%%%%%%%%%%%%%%%
MappedTraces (eta_Mapped_MATRIX, dim_x, TI, Burn_In, Str)

saveas(figure(1),[path_to_figures ' tracce o mapped.jpg'])
saveas(figure(2),[path_to_figures ' tracce B mapped.jpg'])
saveas(figure(3),[path_to_figures ' tracce A mapped.jpg'])
if isempty(Str.x_neg) == 0
    saveas(figure(4),[path_to_figures ' tracce Aneg mapped.jpg'])
end

if isempty(Str.x_lag) == 0
    saveas(figure(5),[path_to_figures ' tracce F mapped.jpg'])
end

if isempty(Str.TimeSteps) == 0
    saveas(figure(6),[path_to_figures ' tracce K mapped.jpg'])
    for l = 1:(TI)
        saveas(figure(6+l),sprintf([path_to_figures ' tracce G_%2d mapped.jpg'],l))
        saveas(figure(6+TI+l),sprintf([path_to_figures ' tracce Gneg_%2d mapped.jpg'],l))
    end
end

%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%% UnMapped Plot %%%%
%%%%%%%%%%%%%%%%%%%%%%%
UnmappedTraces (eta_matrix, dim_x, TI, Burn_In, Str)

saveas(figure(7 + 2*(TI)),[path_to_figures ' tracce o.jpg'])
saveas(figure(8 + 2*(TI)),[path_to_figures ' tracce B.jpg'])
saveas(figure(9 + 2*(TI)),[path_to_figures ' tracce A.jpg'])
if isempty(Str.x_neg) == 0
    saveas(figure(10 + 2*(TI)),[path_to_figures ' tracce Aneg.jpg'])
end
if isempty(Str.x_lag) == 0
    saveas(figure(11 + 2*(TI)),[path_to_figures ' tracce F.jpg'])
end
if isempty(Str.TimeSteps) == 0
    saveas(figure(12 + 2*(TI)),[path_to_figures ' tracce K.jpg'])
    for l = 1:(TI)
        saveas(figure(12 + 2*(TI)+l),sprintf([path_to_figures ' tracce G_%2d.jpg'],l))
        saveas(figure(12 + 2*(TI)+TI+l),sprintf([path_to_figures ' tracce Gneg_%2d.jpg'],l))
    end
end

%%
%%%%%%%%%%%%%%
%%%% ACFs %%%%
%%%%%%%%%%%%%%
NLAGS = 1000;
yToll = 0.05;
MappedACF(eta_Mapped_MATRIX, dim_x, TI, Burn_In, NLAGS, yToll, Str)

saveas(figure(13 + 4*(TI)),[path_to_figures ' ACF o mapped.jpg'])
saveas(figure(14 + 4*(TI)),[path_to_figures ' ACF B mapped.jpg'])
saveas(figure(15 + 4*(TI)),[path_to_figures ' ACF A mapped.jpg'])
if isempty(Str.x_neg) == 0
    saveas(figure(16 + 4*(TI)),[path_to_figures ' ACF Aneg mapped.jpg'])
end
if isempty(Str.x_lag) == 0
    saveas(figure(17 + 4*(TI)),[path_to_figures ' ACF F mapped.jpg'])
end
if isempty(Str.TimeSteps) == 0
    saveas(figure(18 + 4*(TI)),[path_to_figures ' ACF K mapped.jpg'])
    for l = 1:(TI)
        saveas(figure(18 + 4*(TI)+l),sprintf([path_to_figures ' ACF G_%2d mapped.jpg'],l))
        saveas(figure(18 + 4*(TI)+TI+l),sprintf([path_to_figures ' ACF Gneg_%2d mapped.jpg'],l))
    end
end

%%
%%%%%%%%%%%%%%%%%%%%
%%%% Histograms %%%%
%%%%%%%%%%%%%%%%%%%%

MappedHist (eta_Mapped_MATRIX, dim_x, TI, Burn_In, ...
    o_GMEM_TRUE, B_GMEM_TRUE, A_GMEM_TRUE, Aneg_GMEM_TRUE, F_GMEM_TRUE, ...
    K_GMEM_TRUE, G_GMEM_TRUE, Gneg_GMEM_TRUE, Str)

saveas(figure(19 + 6*(TI)),[path_to_figures ' HIST o mapped.jpg'])
saveas(figure(20 + 6*(TI)),[path_to_figures ' HIST B mapped.jpg'])
saveas(figure(21 + 6*(TI)),[path_to_figures ' HIST A mapped.jpg'])
if isempty(Str.x_neg) == 0
    saveas(figure(22 + 6*(TI)),[path_to_figures ' HIST Aneg mapped.jpg'])
end
if isempty(Str.x_lag) == 0
    saveas(figure(23 + 6*(TI)),[path_to_figures ' HIST F mapped.jpg'])
end
if isempty(Str.TimeSteps) == 0
    saveas(figure(24 + 6*(TI)),[path_to_figures ' HIST K mapped.jpg'])
    for l = 1:(TI)
        saveas(figure(24 + 6*(TI)+l),sprintf([path_to_figures ' HIST G_%2d.jpg'],l))
        saveas(figure(24 + 6*(TI)+TI+l),sprintf([path_to_figures ' HIST Gneg_%2d.jpg'],l))
    end
end

%%
%%%%%%%%%%%%%%%
%%%% Times %%%%
%%%%%%%%%%%%%%%
Times = zeros(NBurnIn+NMCMC0+NMCMC1,1);
parfor t = 2:NBurnIn+NMCMC0+NMCMC1
    Times(t) = MC{t}.Time;
end

figure(25 + 8*(TI))
plot(Times,'.')
title('Times')

saveas(figure(25 + 8*(TI)),[path_to_figures ' Times.jpg'])

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Running averages %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
SampleMean_vec = NaN * zeros(length(eta), NBurnIn + NMCMC0 + NMCMC1);
parfor t = 2 : NBurnIn + NMCMC0 + NMCMC1
    SampleMean_vec(:,t) = mean (eta_Mapped_MATRIX(1:t,:))';
end

RunningAverages (SampleMean_vec, dim_x, TI, NBurnIn, NMCMC0, NMCMC1, ...
    o_GMEM_TRUE,B_GMEM_TRUE,A_GMEM_TRUE,Aneg_GMEM_TRUE,F_GMEM_TRUE,K_GMEM_TRUE,...
    G_GMEM_TRUE,Gneg_GMEM_TRUE, Str)

saveas(figure(26 + 8*(TI)),[path_to_figures ' Tracce mean_o_mapped.jpg'])
saveas(figure(27 + 8*(TI)),[path_to_figures ' Tracce mean_B_mapped.jpg'])
saveas(figure(28 + 8*(TI)),[path_to_figures ' Tracce mean_A_mapped.jpg'])
if isempty(Str.x_neg) == 0
    saveas(figure(29 + 8*(TI)),[path_to_figures ' Tracce mean_Aneg_mapped.jpg'])
end
if isempty(Str.x_lag) == 0
    saveas(figure(30 + 8*(TI)),[path_to_figures ' Tracce mean_F_mapped.jpg'])
end
if isempty(Str.TimeSteps) == 0
    saveas(figure(31 + 8*(TI)),[path_to_figures ' Tracce mean_K_mapped.jpg'])
    for l = 1:(TI)
        saveas(figure(31 + 8*(TI)+l),sprintf([path_to_figures ' Tracce mean_G_%2d_mapped.jpg'],l))
        saveas(figure(31 + 8*(TI)+TI+l),sprintf([path_to_figures ' Tracce mean_Gneg_%2d_mapped.jpg'],l))
    end
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Active components and mixture weights %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_vec = NaN * zeros(NTot - Burn_In, 1);
Av_N_vec = NaN * zeros(NTot - Burn_In, 1);
Act_vec   = NaN * zeros(NTot - Burn_In, 1);
Av_Act_vec   = NaN * zeros(NTot - Burn_In, 1);
for i = 1:NTot - Burn_In
    if i == 1
        N_vec(i) = MC{Burn_In + i}.N;
        Av_N_vec(i) = MC{Burn_In + i}.N;
        Act_vec(i) = length(unique(MC{Burn_In + i}.d));
        Av_Act_vec(i) = length(unique(MC{Burn_In + i}.d));
    else
        N_vec(i) = MC{Burn_In + i}.N;
        Av_N_vec(i) = (N_vec(i) + (i-1) * Av_N_vec(i-1)) / i;
        Act_vec(i) = length(unique(MC{Burn_In + i}.d));
        Av_Act_vec(i) = (Act_vec(i) + (i-1) * Av_Act_vec(i-1)) / i ;
    end
end
w_mat     = NaN * zeros(max(N_vec), NTot - Burn_In);
for i = 1:NTot - Burn_In
    w_mat(1:N_vec(i, 1), i) = MC{Burn_In + i}.w;
end

figure(32 + 10 * TI)
subplot(2,1,1)
Max = plot (N_vec);
hold  on
Act = plot(Act_vec,'Color','red');
hold off
legend([Max Act], 'Max', 'Act');
subplot(2,1,2)
AvMax = plot(Av_N_vec);
hold on 
AvAct = plot(Av_Act_vec,'Color','red');
hold off
legend([AvMax AvAct], 'Av.Max', 'Av.Act');

saveas(figure(32 + 10*TI),[path_to_figures ' Components.jpg'])


figure(33 + 10*TI)
plot(w_mat')
legend('w1','w2','w3','w4','w5');
saveas(figure(33 + 10*TI),[path_to_figures ' Weights.jpg'])

MeanWeights = mean(w_mat,2);
MeanWeights(isnan(MeanWeights))=[];
disp('Mean Weights')
disp(MeanWeights)
disp('Sum')
disp(sum(MeanWeights))

N_act = length(MeanWeights);
w_mat_act = w_mat(1:N_act,:);
h_hat = zeros(dim_x,T);
y_hat = zeros(dim_x,T);
mu_array = NaN * zeros(dim_x, N_act, NTot - Burn_In);
Sigma_array = NaN * zeros(dim_x, dim_x, N_act, NTot - Burn_In);

%%% Create arrays of post-processed parameters, vector of estimated
%%% conditional means and a vector of estimated innovations
disp('Computing h_hat and y_hat...')
tic;
parfor t = 1:NTot - Burn_In
    mu_array(:,:,t) = MC{Burn_In + t}.mu(:,1:N_act) - repmat(log(MC{Burn_In + t}.mbar),1,N_act);
    Sigma_array(:,:,:,t) = MC{Burn_In + t}.Sigma(:,:,1:N_act);
    h_hat = h_hat + vMEMh(x, eta_Mapped_MATRIX(Burn_In + t,:)', MC{Burn_In + t}.h_1, Str);
    y_hat = y_hat + x ./ vMEMh(x, eta_Mapped_MATRIX(Burn_In + t,:)', MC{Burn_In + t}.h_1, Str);
end
toc;
h_hat = h_hat / (NTot - Burn_In);
y_hat = y_hat / (NTot - Burn_In);

save(path_to_workspace, '-v7.3')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Innovations' PDF   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Create the grid on which we will evaluate the pdf:
N_1 = 100;
N_2 = 100;
% y_1_grid = linspace(max(min(y(1, :)) - range(y(1, :))/3, 0.01), max(y(1, :)) +  range(y(1, :))/3, N_1)';
% y_2_grid = linspace(max(min(y(2, :)) - range(y(2, :))/3, 0.01), max(y(2, :)) + range(y(2, :))/3, N_2)';
%%%%%
% y_1_grid = linspace(max(min(y(1, :)), 0.01), max(y(1, :)), N_1)';
% y_2_grid = linspace(max(min(y(2, :)), 0.01), max(y(2, :)), N_2)';
%%%%%
y_1_grid = linspace(max(min(y_hat(1, :)), 0.01), max(y_hat(1, :)), N_1)';
y_2_grid = linspace(max(min(y_hat(2, :)), 0.01), max(y_hat(2, :)), N_2)';

y_12_grid = [repmat(y_1_grid, N_2, 1) reshape(repmat(y_2_grid', N_1, 1), N_1 * N_2, 1)];
PDF_Inn_grid_EST = zeros(N_1 * N_2, 1);

disp('Computing the estimated PDF of the Innovations...')
tic;
parfor i_INN = 1:NTot - Burn_In
    N_C_INN = N_vec(i_INN);
    for j = 1:N_C_INN
        PDF_Inn_grid_EST = PDF_Inn_grid_EST + MC{Burn_In + i_INN}.w(j)...
            * mvnpdf(log(y_12_grid), MC{Burn_In + i_INN}.mu(:, j)' - log(MC{Burn_In + i_INN}.mbar)', MC{Burn_In + i_INN}.Sigma(:, :, j)) ./ prod(y_12_grid, 2);
    end
end
toc;
PDF_Inn_grid_EST = PDF_Inn_grid_EST / (NTot - Burn_In);

if exist('o_GMEM_TRUE','var')
    PDF_Inn_grid_TRUE = 0.7 * mvnpdf(log(y_12_grid), -0.5*diag(Sigma1)', Sigma1) ./ prod(y_12_grid, 2) ...
        + 0.3 * mvnpdf(log(y_12_grid), -0.5*diag(Sigma2)', Sigma2) ./ prod(y_12_grid, 2);
    PDF_Inn_grid_TRUE =  reshape(PDF_Inn_grid_TRUE, N_1, N_2);
end

PDF_Inn_grid_MLE = mvnpdf(log(y_12_grid), - 0.5*diag(Sigma_GMEM_MLE)', Sigma_GMEM_MLE) ./ prod(y_12_grid, 2);

PDF_Inn_grid_MLE =  reshape(PDF_Inn_grid_MLE, N_1, N_2);
PDF_Inn_grid_EST = reshape(PDF_Inn_grid_EST, N_1, N_2);


if exist('o_GMEM_TRUE','var')
    figure(34 + 10*TI)
    Tru = contour(y_1_grid, y_2_grid, PDF_Inn_grid_TRUE','LineColor','green');
    hold on
    Mle = contour(y_1_grid, y_2_grid, PDF_Inn_grid_MLE',0.2:0.2:1.4,'LineColor','red');
    Est = contour(y_1_grid, y_2_grid, PDF_Inn_grid_EST',0.2:0.2:1.4,'LineColor','black');
    hold off
    %xlim([0,3])
    %ylim([0,2])
    title(sprintf('PDF of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    saveas(figure(34 + 10*TI),[path_to_figures ' ContourInnovations.jpg'])
    
    marg_Est_x1 = sum(PDF_Inn_grid_EST,2);
    marg_Est_x2 = sum(PDF_Inn_grid_EST,1);    
    marg_Mle_x1 = sum(PDF_Inn_grid_MLE,2);
    marg_Mle_x2 = sum(PDF_Inn_grid_MLE,1);
    marg_TRUE_x1 = sum(PDF_Inn_grid_TRUE,2);
    marg_TRUE_x2 = sum(PDF_Inn_grid_TRUE,1);
    
    figure(35 + 10*TI)
    %%% In case of equally spaced grid:
    plot(y_1_grid,marg_TRUE_x1 / sum(marg_TRUE_x1 * (y_1_grid(2)-y_1_grid(1))),'Color','g')
    hold on
    plot(y_1_grid,marg_Mle_x1 / sum(marg_Mle_x1 * (y_1_grid(2)-y_1_grid(1))),'Color','r')
    plot(y_1_grid,marg_Est_x1 / sum(marg_Est_x1 * (y_1_grid(2)-y_1_grid(1))),'Color','k')
    hold off   
    %%% In case of unequally spaced grid:
%     plot(y_1_grid,marg_TRUE_x1 / sum((marg_TRUE_x1(1:end-1) + marg_TRUE_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','g')
%     hold on
%     plot(y_1_grid,marg_Mle_x1 / sum((marg_Mle_x1(1:end-1) + marg_Mle_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','r')
%     plot(y_1_grid,marg_Est_x1 / sum((marg_Est_x1(1:end-1) + marg_Est_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','k')
%     hold off
    title(sprintf('Marginal PDF of the x_1 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    
    saveas(figure(35 + 10*TI),[path_to_figures ' MarginalInnovations1.jpg'])
    
    figure(36 + 10*TI)
    %%% In case of equally spaced grid:
    plot(y_2_grid, marg_TRUE_x2 / sum(marg_TRUE_x2 * (y_2_grid(2)-y_2_grid(1))),'Color','g')
    hold on
    plot(y_2_grid,marg_Mle_x2 / sum(marg_Mle_x2 * (y_2_grid(2)-y_2_grid(1))),'Color','r')
    plot(y_2_grid,marg_Est_x2 / sum(marg_Est_x2 * (y_2_grid(2)-y_2_grid(1))),'Color','k')
    hold off
    %%% In case of unequally spaced grid:
%     plot(y_2_grid,marg_TRUE_x2 / sum((marg_TRUE_x2(1:end-1) + marg_TRUE_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','g')
%     hold on
%     plot(y_2_grid,marg_Mle_x2 / sum((marg_Mle_x2(1:end-1) + marg_Mle_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','r')
%     plot(y_2_grid,marg_Est_x2 / sum((marg_Est_x2(1:end-1) + marg_Est_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','k')
%     hold off
    title(sprintf('Marginal PDF of the x_2 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    
    saveas(figure(36 + 10*TI),[path_to_figures ' MarginalInnovations2.jpg'])
else
    figure(34 + 10*TI)
    plot(y_hat(1, :), y_hat(2, :), 'o','Color','y')
    hold on
    Est = contour(y_1_grid, y_2_grid, PDF_Inn_grid_EST',0.2:0.2:1.4,'LineColor','black');
    hold off
    xlim([0,3])
    ylim([0,2])
    title(sprintf('DPM model\nPDF of the estimated innovations'))
    saveas(figure(34 + 10*TI),[path_to_figures ' ContourDPMInnovations.jpg'])
    
    marg_Est_x1 = sum(PDF_Inn_grid_EST',1);
    marg_Est_x2 = sum(PDF_Inn_grid_EST',2);
    
    figure(35 + 10*TI)
    histnorm(y_hat(1,:),300,'Color','y','plot')
    set(get(gca,'child'),'FaceColor','y','EdgeColor','y');
    hold on
    %%% In case of equally spaced grid:
    plot(y_1_grid,marg_Est_x1 / sum(marg_Est_x1 * (y_1_grid(2)-y_1_grid(1))),'Color','k')
    %%% In case of unequally spaced grid:
    % plot(y_1_grid,marg_Mle_x1 / sum((marg_Mle_x1(1:end-1) + marg_Mle_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','r')
    % plot(y_1_grid,marg_Est_x1 / sum((marg_Est_x1(1:end-1) + marg_Est_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','k')
    hold off
    title(sprintf('DPM Model\nFirst component of the estimated innovations'))
    saveas(figure(35 + 10*TI),[path_to_figures ' MargDPMInnovations1.jpg'])
    
    figure(36 + 10*TI)
    histnorm(y_hat(2,:),300,'Color','y','plot')
    set(get(gca,'child'),'FaceColor','y','EdgeColor','y');
    hold on
    %%% In case of equally spaced grid:
    plot(y_2_grid,marg_Est_x2 / sum(marg_Est_x2 * (y_2_grid(2)-y_2_grid(1))),'Color','k')
    %%% In case of unequally spaced grid:
    % plot(y_2_grid,marg_Mle_x2 / sum((marg_Mle_x2(1:end-1) + marg_Mle_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','r')
    % plot(y_2_grid,marg_Est_x2 / sum((marg_Est_x2(1:end-1) + marg_Est_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','k')
    hold off
    title(sprintf('DPM Model\nSecond component of the estimated innovations'))
    saveas(figure(36 + 10*TI),[path_to_figures ' MargDPMInnovations2.jpg'])
    
    y_hat_MLE = x./h_MLE;
    
    figure(37 + 10*TI)
    plot(y_hat_MLE(1, :), y_hat_MLE(2, :), 'o','Color','y')
    hold on
    Mle = contour(y_1_grid, y_2_grid, PDF_Inn_grid_MLE',0.2:0.2:1.4,'LineColor','red');
    hold off
    xlim([0,3])
    ylim([0,2])
    title(sprintf('LN Model\nPDF of the estimated innovations'))
    saveas(figure(37 + 10*TI),[path_to_figures ' ContourLNInnovations.jpg'])
    
    marg_Mle_x1 = sum(PDF_Inn_grid_MLE',1);
    marg_Mle_x2 = sum(PDF_Inn_grid_MLE',2);
    
    figure(38 + 10*TI)
    histnorm(y_hat(1,:),300,'Color','y','plot')
    set(get(gca,'child'),'FaceColor','y','EdgeColor','y');
    hold on
    %%% In case of equally spaced grid:
    plot(y_1_grid,marg_Mle_x1 / sum(marg_Mle_x1 * (y_1_grid(2)-y_1_grid(1))),'Color','r')
    %%% In case of unequally spaced grid:
    % plot(y_1_grid,marg_Mle_x1 / sum((marg_Mle_x1(1:end-1) + marg_Mle_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','r')
    % plot(y_1_grid,marg_Est_x1 / sum((marg_Est_x1(1:end-1) + marg_Est_x1(2:end)) * (y_1_grid(2:end) - y_1_grid(1:end-1)) / 2),'Color','k')
    hold off
    title(sprintf('LN Model\nFirst component of the estimated innovations'))
    saveas(figure(38 + 10*TI),[path_to_figures ' MargLNInnovations1.jpg'])
    
    figure(39 + 10*TI)
    histnorm(y_hat(2,:),300,'Color','y','plot')
    set(get(gca,'child'),'FaceColor','y','EdgeColor','y');
    hold on
    %%% In case of equally spaced grid:
    plot(y_2_grid,marg_Mle_x2 / sum(marg_Mle_x2 * (y_2_grid(2)-y_2_grid(1))),'Color','r')
    %%% In case of unevenly spaced grid:
    % plot(y_2_grid,marg_Mle_x2 / sum((marg_Mle_x2(1:end-1) + marg_Mle_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','r')
    % plot(y_2_grid,marg_Est_x2 / sum((marg_Est_x2(1:end-1) + marg_Est_x2(2:end)) * (y_2_grid(2:end) - y_2_grid(1:end-1)) / 2),'Color','k')
    hold off
    title(sprintf('LN Model\nSecond component of the estimated innovations'))
    saveas(figure(39 + 10*TI),[path_to_figures ' MargLNInnovations2.jpg'])
end

%%
if dim_x == 2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% One-Step-Ahead predictive pdf %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if exist('o_GMEM_TRUE','var')
        %%% Creating the grid
        N_1 = 100;
        N_2 = 100;
        % x_1_grid = linspace(max(min(x(1, :)) - range(x(1, :))/3, 0.01), max(x(1, :)) +  range(x(1, :))/3, N_1)';
        % x_2_grid = linspace(max(min(x(2, :)) - range(x(2, :))/3, 0.01), max(x(2, :)) + range(x(2, :))/3, N_2)';
        x_1_grid = linspace(max(min(x(1, :)), 0.01), max(x(1, :)), N_1)';
        x_2_grid = linspace(max(min(x(2, :)), 0.01), max(x(2, :)), N_2)';
        x_12_grid = [repmat(x_1_grid, N_2, 1) reshape(repmat(x_2_grid', N_1, 1), N_1 * N_2, 1)];
        PDF_Pred_grid_EST = zeros(N_1 * N_2, 1);
        
        disp('Computing the estimated OSA predictive...')
        tic;
        parfor i = 1:NTot - Burn_In
            N_C = MC{Burn_In + i}.N;
            h = vMEMh(x, eta_Mapped_MATRIX(Burn_In + i,:)', MC{Burn_In + i}.h_1, Str);
            
            if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
                %%% Model 1 (o,Bdiag,A)
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:size(x,1))'...
                    + eta_Mapped_MATRIX(Burn_In + i, size(x,1) + 1 : 2*size(x,1))' .* h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i,2*size(x,1) + 1 : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1)) * x(:, end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
                %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 3*dim_x + dim_x^2)' .* x_neg(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + dim_x^2 + 1 : 4*dim_x + dim_x^2)' .* x_lag(:, end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
                %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:,end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:,end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 3*dim_x + dim_x^2)' .* x_neg(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + dim_x^2 + 1 : 3*dim_x + 2*dim_x^2),dim_x,dim_x) * x_lag(:,end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
                %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:,end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 2*dim_x + 2*dim_x^2),dim_x,dim_x) * x_neg(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 2*dim_x^2 + 1 : 2*dim_x + 3*dim_x^2),dim_x,dim_x) * x_lag(:,end);
            elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
                %%% Full Base model (o,B,A)
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : dim_x + dim_x^2),dim_x,dim_x) * h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + dim_x^2 + 1 : dim_x + 2*dim_x^2),dim_x,dim_x) * x(:, end);
            elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                    && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
                %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : dim_x + dim_x^2),dim_x,dim_x) * h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + dim_x^2 + 1 : dim_x + 2*dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 2*dim_x^2 + 1 : dim_x + 3*dim_x^2),dim_x,dim_x) * x_neg(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 3*dim_x^2 + 1 : dim_x + 4*dim_x^2),dim_x,dim_x) * x_lag(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 4*dim_x^2 + 1 : 3*dim_x + 4*dim_x^2)' ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + 5*dim_x^2 + 1 : 3*dim_x + 6*dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + 7*dim_x^2 + 1 : 3*dim_x + 8*dim_x^2),dim_x,dim_x) * x_neg(:, end);
            end
            for j = 1:N_C
                PDF_Pred_grid_EST = PDF_Pred_grid_EST + MC{Burn_In + i}.w(j) ...
                    * mvnpdf(log(x_12_grid), MC{Burn_In + i}.mu(:, j)' - log(MC{Burn_In + i}.mbar') + log(h_OSA)', MC{Burn_In + i}.Sigma(:, :, j)) ./ prod(x_12_grid, 2);
            end
        end
        toc;
        
        PDF_Pred_grid_EST = PDF_Pred_grid_EST / (NTot - Burn_In);
        PDF_Pred_grid_EST = reshape(PDF_Pred_grid_EST, N_1, N_2);
        
        %%%%%%%%%%%%%%
        %%%% TRUE %%%%
        %%%%%%%%%%%%%%       
        h_TRUE = vMEMh(x, eta_TRUE, [0.2,0.4], Str);
        
        if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Model 1 (o,Bdiag,A,) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
            %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE .* x_neg(:,end) + F_GMEM_TRUE .* x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
            %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE .* x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
            %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE * x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Full Base model (o,B,A)
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE * h_TRUE(:,end) + A_GMEM_TRUE * x(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
            %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE * h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE * x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end) + K_GMEM_TRUE(:,2) ...
                + G_GMEM_TRUE(:,:,2) * x(:,end) + Gneg_GMEM_TRUE(:,:,2) * x_neg(:,end);
        end
        
        PDF_Pred_grid_TRUE = 0.7 * mvnpdf(log(x_12_grid), - 0.5*diag(Sigma1)' + log(h_TRUE_OSA)', Sigma1) ./ prod(x_12_grid, 2) ...
            + 0.3 * mvnpdf(log(x_12_grid), -0.5*diag(Sigma2)' + log(h_TRUE_OSA)', Sigma2) ./ prod(x_12_grid, 2);
        
        PDF_Pred_grid_TRUE =  reshape(PDF_Pred_grid_TRUE, N_1, N_2);
        
        %%%%%%%%%%%%%
        %%%% MLE %%%%
        %%%%%%%%%%%%%
        % %%%%%%In case there isn't already h_MLE
        h_MLE = vMEMh(x, eta_MLE, mean(x,2), Str);
        
        if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Model 1 (o,Bdiag,A,) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
            %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE .* x_neg(:,end) + F_GMEM_MLE .* x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
            %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE .* x_neg(:,end) + F_GMEM_MLE * x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
            %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE * x_neg(:,end) + F_GMEM_MLE * x_lag(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Full Base model (o,B,A)
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE * h_MLE(:,end) + A_GMEM_MLE * x(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
            %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE * h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE * x_neg(:,end) + F_GMEM_MLE * x_lag(:,end) + K_GMEM_MLE(:,2) ...
                + G_GMEM_MLE(:,:,2) * x(:,end) + Gneg_GMEM_MLE(:,:,2) * x_neg(:,end);
        end
        
        PDF_Pred_grid_MLE = mvnpdf(log(x_12_grid), - 0.5*diag(Sigma_GMEM_MLE)' + log(h_MLE_OSA)', Sigma_GMEM_MLE) ./ prod(x_12_grid, 2);
        PDF_Pred_grid_MLE =  reshape(PDF_Pred_grid_MLE, N_1, N_2);
        
        
        figure(40 + 10*TI)
        Tru = contour(x_1_grid, x_2_grid, PDF_Pred_grid_TRUE','LineColor','green');
        hold on
        Mle = contour(x_1_grid, x_2_grid, PDF_Pred_grid_MLE', 'LineColor','red');
        Est = contour(x_1_grid, x_2_grid, PDF_Pred_grid_EST','LineColor','black');
        hold off
        % ylim([0,25])
        % xlim([0,25])
        title(sprintf('O.S.A. Predictive PDF\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(40 + 10*TI),[path_to_figures ' ContourPredictive.jpg'])
        
        marg_Pred_Est_x1 = sum(PDF_Pred_grid_EST',1);
        marg_Pred_Est_x2 = sum(PDF_Pred_grid_EST',2);
        marg_Pred_Mle_x1 = sum(PDF_Pred_grid_MLE',1);
        marg_Pred_Mle_x2 = sum(PDF_Pred_grid_MLE',2);
        marg_Pred_TRUE_x1 = sum(PDF_Pred_grid_TRUE',1);
        marg_Pred_TRUE_x2 = sum(PDF_Pred_grid_TRUE',2);
        
        figure(41 + 10*TI)
        plot(x_1_grid, marg_Pred_TRUE_x1 / sum(marg_Pred_TRUE_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','g')
        hold on
        plot(x_1_grid, marg_Pred_Mle_x1 / sum(marg_Pred_Mle_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','r')
        plot(x_1_grid, marg_Pred_Est_x1 / sum(marg_Pred_Est_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','k')
        hold off
        %xlim([0,40])
        title(sprintf('Marginal PDF of the x_1 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(41 + 10*TI),[path_to_figures ' MarginalPredictive1.jpg'])
        
        figure(42 + 10*TI)
        plot(x_2_grid, marg_Pred_TRUE_x2 / sum(marg_Pred_TRUE_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','g')
        hold on
        plot(x_2_grid, marg_Pred_Mle_x2 / sum(marg_Pred_Mle_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','r')
        plot(x_2_grid, marg_Pred_Est_x2 / sum(marg_Pred_Est_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','k')
        hold off
        %xlim([0,40])
        title(sprintf('Marginal PDF of the x_2 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(42 + 10*TI),[path_to_figures ' MarginalPredictive2.jpg'])
    end
elseif dim_x == 3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%  Innovations' Marginals  %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    N_1 = 50;
    N_2 = 50;
    N_3 = 50;
    %%%% Large Grid
    % y_1_grid = linspace(max(min(y_hat(1, :)) - range(y_hat(1, :))/3, 0.01), max(y_hat(1, :)) + range(y_hat(1, :))/3, N_1)';
    % y_2_grid = linspace(max(min(y_hat(2, :)) - range(y_hat(2, :))/3, 0.01), max(y_hat(2, :)) + range(y_hat(2, :))/3, N_2)';
    % y_3_grid = linspace(max(min(y_hat(3, :)) - range(y_hat(3, :))/3, 0.01), max(y_hat(3, :)) + range(y_hat(3, :))/3, N_3)';
    %%%% Min - Max Grid
    % y_1_grid = linspace(max(min(y_hat(1, :)),0.01), max(y_hat(1, :)), N_1)';
    % y_2_grid = linspace(max(min(y_hat(2, :)),0.01), max(y_hat(2, :)), N_2)';
    % y_3_grid = linspace(max(min(y_hat(3, :)),0.01), max(y_hat(3, :)), N_3)';
    %%%% Quantile Grid
    y_1_grid = zeros(N_1,1);
    y_2_grid = zeros(N_2,1);
    y_3_grid = zeros(N_3,1);
    %%% Same number of elements in each grid:
    for i_grid = 1:N_1
        y_1_grid(i_grid) = quantile(y_hat(1,:), (i_grid - 1) / N_1);
        y_2_grid(i_grid) = quantile(y_hat(2,:), (i_grid - 1) / N_1);
        y_3_grid(i_grid) = quantile(y_hat(3,:), (i_grid - 1) / N_1);
    end
    %%% Unequally noumerous quantile grid:
    % for i_grid_1 = 1:N_1 + 1
    %     y_1_grid(i_grid_1) = quantile(y_hat(1,:), (i_grid_1 - 1) / N_1);
    % end
    % for i_grid_2 = 1:N_2 + 1
    %     y_2_grid(i_grid_2) = quantile(y_hat(2,:), (i_grid_2 - 1) / N_2);
    % end
    % for i_grid_3 = 1:N_3 + 1
    %     y_3_grid(i_grid_3) = quantile(y_hat(3,:), (i_grid_3 - 1) / N_3);
    % end
    
    y_12_grid = [repmat(y_1_grid, N_2, 1) reshape(repmat(y_2_grid', N_1, 1), N_1 * N_2, 1)];
    y_123_grid = [repmat(y_12_grid, N_3,1) reshape(repmat(y_3_grid', N_1 * N_2, 1), N_1 * N_2 * N_3, 1)];
    PDF_Inn_grid_EST = zeros(N_1 * N_2 * N_3, 1);
    
    disp('Computing the estimated PDF of the Innovations...')
    tic;
    parfor i = 1:NTot - Burn_In
        tic
        N_C = N_vec(i);
        for j = 1:N_C
            PDF_Inn_grid_EST = PDF_Inn_grid_EST + MC{Burn_In + i}.w(j)...
                * mvnpdf(log(y_123_grid), MC{Burn_In + i}.mu(:, j)' - log(MC{Burn_In + i}.mbar)', MC{Burn_In + i}.Sigma(:, :, j)) ./ prod(y_123_grid, 2);
        end
        toc
    end
    toc;
    
    PDF_Inn_grid_EST = PDF_Inn_grid_EST / (NTot - Burn_In);
    
    PDF_Inn_grid_TRUE = 0.7 * mvnpdf(log(y_123_grid), -0.5*diag(Sigma1)', Sigma1) ./ prod(y_123_grid, 2) ...
        + 0.3 * mvnpdf(log(y_123_grid), -0.5*diag(Sigma2)', Sigma2) ./ prod(y_123_grid, 2);
    
    PDF_Inn_grid_MLE = mvnpdf(log(y_123_grid), - 0.5*diag(Sigma_GMEM_MLE)', Sigma_GMEM_MLE) ./ prod(y_123_grid, 2);
    
    PDF_Inn_grid_MLE =  reshape(PDF_Inn_grid_MLE, N_1, N_2, N_3);
    PDF_Inn_grid_EST = reshape(PDF_Inn_grid_EST, N_1, N_2, N_3);
    PDF_Inn_grid_TRUE =  reshape(PDF_Inn_grid_TRUE, N_1, N_2, N_3);
    
    marg_Est_x1 = sum(sum(PDF_Inn_grid_EST,3),2);
    marg_Est_x2 = sum(sum(PDF_Inn_grid_EST,3),1);
    marg_Est_x3 = squeeze(sum(sum(PDF_Inn_grid_EST,1),2));
    marg_Mle_x1 = sum(sum(PDF_Inn_grid_MLE,3),2);
    marg_Mle_x2 = sum(sum(PDF_Inn_grid_MLE,3),1);
    marg_Mle_x3 = squeeze(sum(sum(PDF_Inn_grid_MLE,1),2));
    marg_TRUE_x1 = sum(sum(PDF_Inn_grid_TRUE,3),2);
    marg_TRUE_x2 = sum(sum(PDF_Inn_grid_TRUE,3),1);
    marg_TRUE_x3 = squeeze(sum(sum(PDF_Inn_grid_TRUE,1),2));
    
    figure(34 + 10*TI)
    %%%%% Equally spaced grid:
    % plot(y_1_grid, marg_TRUE_x1 / sum(marg_TRUE_x1 * (y_1_grid(2) - y_1_grid(1))),'Color','g')
    % hold on
    % plot(y_1_grid,marg_Mle_x1 / sum(marg_Mle_x1 * (y_1_grid(2) - y_1_grid(1))),'Color','r')
    % plot(y_1_grid,marg_Est_x1 / sum(marg_Est_x1 * (y_1_grid(2) - y_1_grid(1))),'Color','k')
    % hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Unequally spaced grid:
    plot(y_1_grid, marg_TRUE_x1 / sum(marg_TRUE_x1 .* ([y_1_grid(2:end) - y_1_grid(1:end-1); mean(y_1_grid(2:end) - y_1_grid(1:end-1))])),'Color','g')
    hold on
    plot(y_1_grid, marg_Mle_x1 / sum(marg_Mle_x1 .* ([y_1_grid(2:end) - y_1_grid(1:end-1); mean(y_1_grid(2:end) - y_1_grid(1:end-1))])),'Color','r')
    plot(y_1_grid, marg_Est_x1 / sum(marg_Est_x1 .* ([y_1_grid(2:end) - y_1_grid(1:end-1); mean(y_1_grid(2:end) - y_1_grid(1:end-1))])),'Color','k')
    hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %xlim([0,25])
    title(sprintf('Marginal PDF of the x_1 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    
    saveas(figure(34 + 10*TI),[path_to_figures ' MarginalInnovations1.jpg'])
    
    figure(35 + 10*TI)
    %%% Equally spaced grid:
    % plot(y_2_grid,marg_TRUE_x2 / sum(marg_TRUE_x2 * (y_2_grid(2) - y_2_grid(1))),'Color','g')
    % hold on
    % plot(y_2_grid,marg_Est_x2 / sum(marg_Est_x2 * (y_2_grid(2) - y_2_grid(1))),'Color','k')
    % plot(y_2_grid,marg_Mle_x2 / sum(marg_Mle_x2 * (y_2_grid(2) - y_2_grid(1))),'Color','r')
    % hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Unequally spaced grid:
    plot(y_2_grid, marg_TRUE_x2 / sum(marg_TRUE_x2' .* ([y_2_grid(2:end) - y_2_grid(1:end-1); mean(y_2_grid(2:end) - y_2_grid(1:end-1))])),'Color','g')
    hold on
    plot(y_2_grid, marg_Mle_x2 / sum(marg_Mle_x2' .* ([y_2_grid(2:end) - y_2_grid(1:end-1); mean(y_2_grid(2:end) - y_2_grid(1:end-1))])),'Color','r')
    plot(y_2_grid, marg_Est_x2 / sum(marg_Est_x2' .* ([y_2_grid(2:end) - y_2_grid(1:end-1); mean(y_2_grid(2:end) - y_2_grid(1:end-1))])),'Color','k')
    hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    title(sprintf('Marginal PDF of the x_2 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    
    saveas(figure(35 + 10*TI),[path_to_figures ' MarginalInnovations2.jpg'])
    
    figure(36 + 10*TI)
    %%% Equally spaced grid:
    % plot(y_3_grid,marg_TRUE_x3 / sum(marg_TRUE_x3 * (y_3_grid(2) - y_3_grid(1))),'Color','g')
    % hold on
    % plot(y_3_grid,marg_Est_x3 / sum(marg_Est_x3 * (y_3_grid(2) - y_3_grid(1))),'Color','k')
    % plot(y_3_grid,marg_Mle_x3 / sum(marg_Mle_x3 * (y_3_grid(2) - y_3_grid(1))),'Color','r')
    % hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Unequally spaced grid:
    plot(y_3_grid, marg_TRUE_x3 / sum(marg_TRUE_x3' .* ([y_3_grid(2:end) - y_3_grid(1:end-1); mean(y_3_grid(2:end) - y_3_grid(1:end-1))])),'Color','g')
    hold on
    plot(y_3_grid, marg_Mle_x3 / sum(marg_Mle_x3' .* ([y_3_grid(2:end) - y_3_grid(1:end-1); mean(y_3_grid(2:end) - y_3_grid(1:end-1))])),'Color','r')
    plot(y_3_grid, marg_Est_x3 / sum(marg_Est_x3' .* ([y_3_grid(2:end) - y_3_grid(1:end-1); mean(y_3_grid(2:end) - y_3_grid(1:end-1))])),'Color','k')
    hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %xlim([0,35])
    %ylim([0,50])
    title(sprintf('Marginal PDF of the x_3 component of the innovations\nGREEN = true, BLACK = DPM, RED = Parametric model'))
    
    saveas(figure(36 + 10*TI),[path_to_figures ' MarginalInnovations3.jpg'])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%  Predictives' Marginals  %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if exist('o_GMEM_TRUE','var')
        N_1 = 50;
        N_2 = 50;
        N_3 = 50;
        %%% Large Grid
        % x_1_grid = linspace(max(min(x(1, :)) - range(x(1, :))/3, 0.01), max(x(1, :)) + range(x(1, :))/3, N_1)';
        % x_2_grid = linspace(max(min(x(2, :)) - range(x(2, :))/3, 0.01), max(x(2, :)) + range(x(2, :))/3, N_2)';
        % x_3_grid = linspace(max(min(x(3, :)) - range(x(3, :))/3, 0.01), max(x(3, :)) + range(x(3, :))/3, N_3)';
        %%% Min - Max Grid
        % x_1_grid = linspace(max(min(x(1, :)), 0.01), max(x(1, :)), N_1)';
        % x_2_grid = linspace(max(min(x(2, :)), 0.01), max(x(2, :)), N_2)';
        % x_3_grid = linspace(max(min(x(3, :)), 0.01), max(x(3, :)), N_3)';
        %%%% Quantile Grid:
        x_1_grid = zeros(N_1,1);
        x_2_grid = zeros(N_2,1);
        x_3_grid = zeros(N_3,1);
        %%% Same number of elements in each grid:
        for i_grid = 1:N_1
            x_1_grid(i_grid) = quantile(x(1,:), (i_grid - 1) / N_1);
            x_2_grid(i_grid) = quantile(x(2,:), (i_grid - 1) / N_1);
            x_3_grid(i_grid) = quantile(x(3,:), (i_grid - 1) / N_1);
        end
        %%% Unequally noumerous quantile grid:
        % for i_grid_1 = 1:N_1 + 1
        %     x_1_grid(i_grid_1) = quantile(x(1,:), (i_grid_1 - 1) / N_1);
        % end
        % for i_grid_2 = 1:N_2 + 1
        %     x_2_grid(i_grid_2) = quantile(x(2,:), (i_grid_2 - 1) / N_2);
        % end
        % for i_grid_3 = 1:N_3 + 1
        %     x_3_grid(i_grid_3) = quantile(x(3,:), (i_grid_3 - 1) / N_3);
        % end
        x_12_grid = [repmat(x_1_grid, N_2, 1) reshape(repmat(x_2_grid', N_1, 1), N_1 * N_2, 1)];
        x_123_grid = [repmat(x_12_grid, N_3,1) reshape(repmat(x_3_grid', N_1 * N_2, 1), N_1 * N_2 * N_3, 1)];
        PDF_Pred_grid_EST = zeros(N_1 * N_2 * N_3, 1);
        
        disp('Computing the estimated OSA predictive...')
        tic;
        parfor i = 1:NTot - Burn_In
            tic
            N_C = MC{Burn_In + i}.N;
            h = vMEMh(x, eta_Mapped_MATRIX(Burn_In + i,:)', MC{Burn_In + i}.h_1, Str);
            
            if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
                %%% Model 1 (o,Bdiag,A)
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:size(x,1))'...
                    + eta_Mapped_MATRIX(Burn_In + i, size(x,1) + 1 : 2*size(x,1))' .* h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i,2*size(x,1) + 1 : 2*size(x,1) + size(x,1)^2),size(x,1),size(x,1)) * x(:, end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
                %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 3*dim_x + dim_x^2)' .* x_neg(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + dim_x^2 + 1 : 4*dim_x + dim_x^2)' .* x_lag(:, end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
                %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:,end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:,end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 3*dim_x + dim_x^2)' .* x_neg(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + dim_x^2 + 1 : 3*dim_x + 2*dim_x^2),dim_x,dim_x) * x_lag(:,end);
            elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                    && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
                %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : 2*dim_x)' .* h(:,end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 1 : 2*dim_x + dim_x^2),dim_x,dim_x) * x(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + dim_x^2 + 1 : 2*dim_x + 2*dim_x^2),dim_x,dim_x) * x_neg(:,end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 2*dim_x^2 + 1 : 2*dim_x + 3*dim_x^2),dim_x,dim_x) * x_lag(:,end);
            elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
                %%% Full Base model (o,B,A)
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : dim_x + dim_x^2),dim_x,dim_x) * h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + dim_x^2 + 1 : dim_x + 2*dim_x^2),dim_x,dim_x) * x(:, end);
            elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                    && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
                %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
                h_OSA = eta_Mapped_MATRIX(Burn_In + i,1:dim_x)'...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 1 : dim_x + dim_x^2),dim_x,dim_x) * h(:, end)...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + dim_x^2 + 1 : dim_x + 2*dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 2*dim_x^2 + 1 : dim_x + 3*dim_x^2),dim_x,dim_x) * x_neg(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, dim_x + 3*dim_x^2 + 1 : dim_x + 4*dim_x^2),dim_x,dim_x) * x_lag(:, end) ...
                    + eta_Mapped_MATRIX(Burn_In + i, 2*dim_x + 4*dim_x^2 + 1 : 3*dim_x + 4*dim_x^2)' ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + 5*dim_x^2 + 1 : 3*dim_x + 6*dim_x^2),dim_x,dim_x) * x(:, end) ...
                    + reshape(eta_Mapped_MATRIX(Burn_In + i, 3*dim_x + 7*dim_x^2 + 1 : 3*dim_x + 8*dim_x^2),dim_x,dim_x) * x_neg(:, end);
            end
            for j = 1:N_C
                PDF_Pred_grid_EST = PDF_Pred_grid_EST + MC{Burn_In + i}.w(j) ...
                    * mvnpdf(log(x_123_grid), MC{Burn_In + i}.mu(:, j)' - log(MC{Burn_In + i}.mbar') + log(h_OSA)', MC{Burn_In + i}.Sigma(:, :, j)) ./ prod(x_123_grid, 2);
            end
            toc
        end
        toc;
        
        PDF_Pred_grid_EST = PDF_Pred_grid_EST / (NTot - Burn_In);
        PDF_Pred_grid_EST = reshape(PDF_Pred_grid_EST, N_1, N_2, N_3);
        
        %%%%%%%%%%%%%%
        %%%% TRUE %%%%
        %%%%%%%%%%%%%%       
        h_TRUE = vMEMh(x, eta_TRUE, [0.2,0.4], Str);
        
        if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Model 1 (o,Bdiag,A,) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
            %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE .* x_neg(:,end) + F_GMEM_TRUE .* x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
            %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE .* x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
            %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE .* h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE * x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Full Base model (o,B,A)
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE * h_TRUE(:,end) + A_GMEM_TRUE * x(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
            %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
            h_TRUE_OSA = o_GMEM_TRUE + B_GMEM_TRUE * h_TRUE(:,end) + A_GMEM_TRUE * x(:,end) ...
                + Aneg_GMEM_TRUE * x_neg(:,end) + F_GMEM_TRUE * x_lag(:,end) + K_GMEM_TRUE(:,2) ...
                + G_GMEM_TRUE(:,:,2) * x(:,end) + Gneg_GMEM_TRUE(:,:,2) * x_neg(:,end);
        end
        
        PDF_Pred_grid_TRUE = 0.7 * mvnpdf(log(x_12_grid), - 0.5*diag(Sigma1)' + log(h_TRUE_OSA)', Sigma1) ./ prod(x_12_grid, 2) ...
            + 0.3 * mvnpdf(log(x_12_grid), -0.5*diag(Sigma2)' + log(h_TRUE_OSA)', Sigma2) ./ prod(x_12_grid, 2);
        
        PDF_Pred_grid_TRUE =  reshape(PDF_Pred_grid_TRUE, N_1, N_2);
        
        %%%%%%%%%%%%%
        %%%% MLE %%%%
        %%%%%%%%%%%%%
        % %%%%%%In case there isn't already h_MLE
        h_MLE = vMEMh(x, eta_MLE, mean(x,2), Str);
        
        if Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Model 1 (o,Bdiag,A,) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && Str.isdiagF
            %%% Model 2 (o,Bdiag,A,AnegDiag,Fdiag) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE .* x_neg(:,end) + F_GMEM_MLE .* x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && Str.isdiagAneg && ~Str.isdiagF
            %%% Model 3 (o,Bdiag,A,AnegDiag,F) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE .* x_neg(:,end) + F_GMEM_MLE * x_lag(:,end);
        elseif Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) ...
                && isempty(Str.TimeSteps) && ~Str.isdiagAneg && ~Str.isdiagF
            %%% Model 4 (o,Bdiag,A,Aneg,F) %%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE .* h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE * x_neg(:,end) + F_GMEM_MLE * x_lag(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && isempty(Str.x_neg) && isempty(Str.x_lag) && isempty(Str.TimeSteps)
            %%% Full Base model (o,B,A)
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE * h_MLE(:,end) + A_GMEM_MLE * x(:,end);
        elseif ~Str.isdiagB && ~Str.isdiagA && ~isempty(Str.x_neg) && ~isempty(Str.x_lag) && isempty(Str.TimeSteps) ...
                && ~Str.isdiagAneg && ~Str.isdiagF && length(Str.TimeSteps) == 3
            %%% Complete full model with 3 time periods (o,B,A,Aneg,F,K,G1,G2,Gneg1,Gneg2)%%%%
            h_MLE_OSA = o_GMEM_MLE + B_GMEM_MLE * h_MLE(:,end) + A_GMEM_MLE * x(:,end) ...
                + Aneg_GMEM_MLE * x_neg(:,end) + F_GMEM_MLE * x_lag(:,end) + K_GMEM_MLE(:,2) ...
                + G_GMEM_MLE(:,:,2) * x(:,end) + Gneg_GMEM_MLE(:,:,2) * x_neg(:,end);
        end

        PDF_Pred_grid_MLE = mvnpdf(log(x_123_grid), - 0.5*diag(Sigma_GMEM_MLE)' + log(h_MLE_OSA)', Sigma_GMEM_MLE) ./ prod(x_123_grid, 2);
        PDF_Pred_grid_MLE =  reshape(PDF_Pred_grid_MLE, N_1, N_2, N_3);
        
        marg_Pred_Est_x1 = sum(sum(PDF_Pred_grid_EST,3),2);
        marg_Pred_Est_x2 = sum(sum(PDF_Pred_grid_EST,3),1);
        marg_Pred_Est_x3 = squeeze(sum(sum(PDF_Pred_grid_EST,1),2));        
        marg_Pred_Mle_x1 = sum(sum(PDF_Pred_grid_MLE,3),2);
        marg_Pred_Mle_x2 = sum(sum(PDF_Pred_grid_MLE,3),1);
        marg_Pred_Mle_x3 = squeeze(sum(sum(PDF_Pred_grid_MLE,1),2));        
        marg_Pred_TRUE_x1 = sum(sum(PDF_Pred_grid_TRUE,3),2);
        marg_Pred_TRUE_x2 = sum(sum(PDF_Pred_grid_TRUE,3),1);
        marg_Pred_TRUE_x3 = squeeze(sum(sum(PDF_Pred_grid_TRUE,1),2));
        
        figure(38 + 10*TI)
        %%%% Equally spaced grid:
        % plot(x_1_grid, marg_Pred_TRUE_x1 / sum(marg_Pred_TRUE_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','g')
        % hold on
        % plot(x_1_grid, marg_Pred_Mle_x1 / sum(marg_Pred_Mle_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','r')
        % plot(x_1_grid, marg_Pred_Est_x1 / sum(marg_Pred_Est_x1 * (x_1_grid(2) - x_1_grid(1))),'Color','k')
        % hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Unequally spaced grid:
        plot(x_1_grid, marg_Pred_TRUE_x1 / sum(marg_Pred_TRUE_x1 .* ([x_1_grid(2:end) - x_1_grid(1:end-1); mean(x_1_grid(2:end) - x_1_grid(1:end-1))])),'Color','g')
        hold on
        plot(x_1_grid, marg_Pred_Mle_x1 / sum(marg_Pred_Mle_x1 .* ([x_1_grid(2:end) - x_1_grid(1:end-1); mean(x_1_grid(2:end) - x_1_grid(1:end-1))])),'Color','r')
        plot(x_1_grid, marg_Pred_Est_x1 / sum(marg_Pred_Est_x1 .* ([x_1_grid(2:end) - x_1_grid(1:end-1); mean(x_1_grid(2:end) - x_1_grid(1:end-1))])),'Color','k')
        hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %xlim([0,10])
        %ylim([0,2.3e-4])
        title(sprintf('Marginal predictive PDF for the x_1 component\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(38 + 10*TI),[path_to_figures ' MarginalPredictive1.jpg'])
        
        figure(39 + 10*TI)
        %%%% Equally spaced grid:
        % plot(x_2_grid, marg_Pred_TRUE_x2 / sum(marg_Pred_TRUE_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','g')
        % hold on
        % plot(x_2_grid, marg_Pred_Mle_x2 / sum(marg_Pred_Mle_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','r')
        % plot(x_2_grid, marg_Pred_Est_x2 / sum(marg_Pred_Est_x2 * (x_2_grid(2) - x_2_grid(1))),'Color','k')
        % hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Unequally spaced grid:
        plot(x_2_grid, marg_Pred_TRUE_x2 / sum(marg_Pred_TRUE_x2' .* ([x_2_grid(2:end) - x_2_grid(1:end-1); mean(x_2_grid(2:end) - x_2_grid(1:end-1))])),'Color','g')
        hold on
        plot(x_2_grid, marg_Pred_Mle_x2 / sum(marg_Pred_Mle_x3' .* ([x_2_grid(2:end) - x_2_grid(1:end-1); mean(x_2_grid(2:end) - x_2_grid(1:end-1))])),'Color','r')
        plot(x_2_grid, marg_Pred_Est_x2 / sum(marg_Pred_Est_x3' .* ([x_2_grid(2:end) - x_2_grid(1:end-1); mean(x_2_grid(2:end) - x_2_grid(1:end-1))])),'Color','k')
        hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %xlim([0,8])
        %ylim([0,2.6e-4])
        title(sprintf('Marginal predictive PDF for the x_2 component\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(39 + 10*TI),[path_to_figures ' MarginalPredictive2.jpg'])
        
        figure(40 + 10*TI)
        %%% Equally spaced grid:
        % plot(x_3_grid, marg_Pred_TRUE_x3 / sum(marg_Pred_TRUE_x3 * (x_3_grid(2) - x_3_grid(1))),'Color','g')
        % hold on
        % plot(x_3_grid, marg_Pred_Mle_x3 / sum(marg_Pred_Mle_x3 * (x_3_grid(2) - x_3_grid(1))),'Color','r')
        % plot(x_3_grid, marg_Pred_Est_x3 / sum(marg_Pred_Est_x3 * (x_3_grid(2) - x_3_grid(1))),'Color','k')
        % hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Unequally spaced grid:
        plot(x_3_grid, marg_Pred_TRUE_x3 / sum(marg_Pred_TRUE_x3' .* ([x_3_grid(2:end) - x_3_grid(1:end-1); mean(x_3_grid(2:end) - x_3_grid(1:end-1))])),'Color','g')
        hold on
        plot(x_3_grid, marg_Pred_Mle_x3 / sum(marg_Pred_Mle_x3' .* ([x_3_grid(2:end) - x_3_grid(1:end-1); mean(x_3_grid(2:end) - x_3_grid(1:end-1))])),'Color','r')
        plot(x_3_grid, marg_Pred_Est_x3 / sum(marg_Pred_Est_x3' .* ([x_3_grid(2:end) - x_3_grid(1:end-1); mean(x_3_grid(2:end) - x_3_grid(1:end-1))])),'Color','k')
        hold off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %xlim([0,8])
        %ylim([0,2.4e-4])
        title(sprintf('Marginal predictive PDF for the x_3 component\nGREEN = true, BLACK = DPM, RED = Parametric model'))
        
        saveas(figure(40 + 10*TI),[path_to_figures ' MarginalPredictive3.jpg'])
    end
end
    
%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%% Scatter Plots %%%%
%%%%%%%%%%%%%%%%%%%%%%%
figure(41 + 10*TI);
[H,AX,BigAx,P,PAx] = plotmatrix(eta_Mapped_MATRIX(:, :));
title('Scatter')

saveas(figure(43 + 10*TI),[path_to_figures ' Scatter mappati.jpg'])

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Log predictive scores %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LPS Computations: In the Sample

ff_mat = zeros(T,NTot - Burn_In);
disp('************************************************')
disp(['Calculation of the LPS started at: ' datestr(now)])
disp('************************************************')
tic
parfor t_lps = 1:T
    tic
    for j_lps = 1:N_act
        ff_mat(t_lps,:) = ff_mat(t_lps,:) + (mvnpdf(log(x(:,t_lps))',squeeze(mu_array(:,j_lps,:))' + repmat(log(h_hat(:,t_lps))', NTot - Burn_In, 1),...
            squeeze(Sigma_array(:,:,j_lps,:))) .* w_mat_act(j_lps,:)' / prod(x(:,t_lps)))';
    end
    toc
end
toc
ff_vec = mean(ff_mat,2); % T*1
fff_vec = mvnpdf(log(x)' - log(h_MLE)', -0.5*diag(Sigma_GMEM_MLE)', Sigma_GMEM_MLE) ./ prod(x)'; % T*1

disp('1-Component LN          DPM (2Params)')
[-mean(log(fff_vec)) -mean(log(ff_vec))]

clear ff_mat
save(path_to_workspace, '-v7.3')
%%
%%%%%%%%%%%%%%%%%
% Export to lyx %
%%%%%%%%%%%%%%%%%

eta_MCMC = mean(eta_Mapped_MATRIX(Burn_In + 1:end,:))';
Quantiles = [quantile(eta_Mapped_MATRIX(Burn_In + 1:end,:),0.025)' quantile(eta_Mapped_MATRIX(Burn_In + 1:end,:),0.975)'];
[SokalSE,tau_int] = SokalStdErr1(eta_Mapped_MATRIX(Burn_In + 1:end,:));

if exist('o_GMEM_TRUE','var')
    EXPORT_MATRIX = [eta_TRUE, eta_MLE, sqrt(diag(VC_BurnIn)), eta_MCMC, Quantiles, SokalSE, tau_int];
else
    EXPORT_MATRIX = [eta_MLE, sqrt(diag(VC_BurnIn)), eta_MCMC, Quantiles, SokalSE, tau_int];
end
matrix2lyx(EXPORT_MATRIX, 'ExportMatrix.lyx', '%f')