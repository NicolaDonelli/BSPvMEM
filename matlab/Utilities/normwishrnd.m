function [Omega, theta, Sigma] = normwishrnd(a, W, mu, n0) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function generates a random number from Normal-Wishart distribution.
%
% Omega         ~ Wishart(a, W)
% theta | Omega ~ Normal(mu, n0 * Omega)
% n0 * Omega is the precision matrix.
% a : is d.o.f. of Wishart distribution (a > d - 1)
% W : Scale matrix of Wishart distribution
%
% ref. : The Bayesian Choice, Chapter 3, p. 147 and Chapter 4, p. 189
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omega = wishrnd(W, a);
Sigma = inv(Omega);
theta = mvnrnd(mu, Sigma / n0)';
