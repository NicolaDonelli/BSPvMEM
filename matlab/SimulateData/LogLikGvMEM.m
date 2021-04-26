function LL = LogLikGvMEM(eta, x, Str)

% eta = [reshape([omega, A, B, Aneg, f, K(1), ..., K(l-1), G(1), ...
%        ,G(l-1), Gneg(1), ..., Gneg(l-1)],1,d + d^2 + d*l*(1+2d)) ...
%        , row vector of variances, Polar']
%
% Given U, the Upper Cholesky matrix of the Correlation matrix, and called
% u_i=[u_1i,...,u_ii]' for i=2,...,d the non-null part of its i-th column 
% vector, it is a versor and so we can reprametrize it in i-1 polar 
% (hyperspherical) coordinates as polar_i=[p_i-1,...,p_2i-3]' for i=2,...,d. 
% The vector Polar is given by [polar_2;...;polar_d] and is made of the
% stacked reparametrizations of the "column" of U.
%
% With this formulation we know that the (2i-3)-th elements of the vector
% Polar (for i=2,...,d) vary in [0,2*pi] while the others vary in [0,pi]
% 
% x is the data vector
% Str is a structure array that contains the flags to indicate the
% specification of the conditional mean
%
% GENERAL vMEM
%
% x(t) = h(t) * e(t)
% e(t) ~ LogNormal (-diag(Sigma)/2,Sigma) [so that E[e(t)]=1]
%
% h(t) = omega + B * h(t-1) + A * x(t-1) + Aneg * y(t-1) +
%   + F * x(t-2) + K(:,1)*I(t_1< t-1 <t_2) + ... + K(:,l-1)*I(t_(l-1)< t-1 <T) +
%   + G(:,:,1)*x(t-1)*I(t_1< t-1 <t_2) + ... + G(:,:,l-1)*x(t-1)*I(t_(l-1)< t-1 <T) +
%   + Gneg(:,:,1)*y(t-1)*I(t_1< t-1 <t_2) + ... + Gneg(:,:,l-1)*y(t-1)*I(t_(l-1)< t-1 <T) 
% RETURNS ARE IN PERCENTAGES, LIKE X

d = size(x,1);

if size(eta,1) > 1
    eta = eta';
end

polar = eta(end - d*(d-1)*0.5 + 1: end)';
s = sqrt(eta(end - d*(d-1)*0.5 - d + 1:end - d*(d-1)*0.5));
%%% if are passed the SD instead of the variances
%s = eta(end - d*(d-1)*0.5 - d + 1:end - d*(d-1)*0.5); 
Corr = ThetaVec2CorrMat(polar);
Sigma = corr2cov (s,Corr);

h_1 = mean(x,2);
h = vMEMh(x, eta(1:end - d*(d-1)*0.5 - d), h_1, Str);
 
LL = - nansum( -sum(log(x),1)' + log( mvnpdf(log(x)' - log(h)', -0.5*diag(Sigma)', Sigma) ) );