function [LogPost,h] = vMEMFullCond(eta,d,mu,Sigma,x,Mean_prior,VC_prior,h_1,Pos,Str)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computes the value of the full conditional of the vector, eta, 
% containing the parameters of the conditional mean
% INPUT:
% eta :         is a vector that contains in this order (if present)
%                - omega (dim_x*1 vector)
%                - B (dim_x*dim_x matrix)
%                - A (dim_x*dim_x matrix)
%                - Aneg (dim_x*dim_x matrix)
%                - F (dim_x*dim_x matrix)
%                - K (dim_x*(l-1) matrix)
%                - G (dim_x*dim_x*(l-1) array)
%                - Gneg (dim_x*dim_x*(l-1) array)
%               (MATRICES AND ARRAYS ARE VECTORIZED)
% d:            dim_x * T vector of latent labels
% mu:           dim_x * N matrix of means of the component of the DPM
% Sigma:        dim_x * dim_x * N array in which each page is the VC matrix
%                of a component of the DPM
% x:            dim_x * T data vector
% Mean_prior:   prior vector mean of the eta vector
% VC_prior:     prior VC matrix of the eta vector
% h_1:          dim_x * 1 vector of initial values of h
% Pos:          Logical flag that indicates wheter or not the eta vector 
%                has to be constrained on the positive orthant
% Str:          Structure array describing the specification of the 
%                conditional mean
% OUTPUT:
% LogPost:      value of the full conditional in the given eta value.
% h:            dim_x * T matrix of conditional means
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = vMEMh(x, eta, h_1, Str);

if ~Pos % the value of eta is not constrained into the positive orthant
    if min(min(h)) > 0 && max(max(h)) < Inf
        CenterData = log(x) - log(h) - mu(:,d);
        uniq_d = unique(d);
        SumKerLogLik = zeros (1,length(uniq_d));
        for j = 1:length(uniq_d)
            SumKerLogLik(j) = sum(sum((CenterData(:,d==uniq_d(j))'...
                / cholcov(Sigma(:,:,uniq_d(j)))).^2,2));
        end
        LogPost = -0.5 * (nansum(SumKerLogLik) + (eta - Mean_prior)' ...
            / VC_prior * (eta - Mean_prior));
    else
        LogPost = -Inf;
    end
else % the value of eta is constrained into the positive orthant
    if min(eta) > 0 
        CenterData = log(x) - log(h) - mu(:,d);
        uniq_d = unique(d);
        SumKerLogLik = zeros (1,length(uniq_d));
        for j = 1:length(uniq_d)
            SumKerLogLik(j) = sum(sum((CenterData(:,d==uniq_d(j))' ...
                / cholcov(Sigma(:,:,uniq_d(j)))).^2,2));
        end   
        LogPost = -0.5 * (nansum(SumKerLogLik) + (eta - Mean_prior)' ...
            / VC_prior * (eta - Mean_prior));
    else
        LogPost = -Inf;
    end
end