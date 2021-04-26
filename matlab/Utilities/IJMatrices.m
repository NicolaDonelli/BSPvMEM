%[I, J] = IJMatrices('LogLikMEM1_vec', Params_Opt', DATA);

function [I, J] = IJMatrices(f, theta, varargin)

%x = theta;
k = length(theta);
tol1 = 1e-2;
tol2 = 1e-4;
h = tol1 * max(abs(theta), tol2);

N  = length(feval(f, theta, varargin{:}));

J = zeros(k, k);
for i = 1:k
    for j=1:i-1
        perturb_i    = zeros(k, 1);
        perturb_j    = zeros(k, 1);
        perturb_i(i) = h(i);
        perturb_j(j) = h(j);
        fipjp = nansum(feval(f, theta + perturb_i + perturb_j, varargin{:}));
        fipjm = nansum(feval(f, theta + perturb_i - perturb_j, varargin{:}));
        fimjp = nansum(feval(f, theta - perturb_i + perturb_j, varargin{:}));
        fimjm = nansum(feval(f, theta - perturb_i - perturb_j, varargin{:}));
        J(i, j) = (fipjp - fipjm - fimjp + fimjm) / (4 * h(i) * h(j));
        J(j, i) = J(i, j);
    end
end
for i = 1:k
    perturb_i    = zeros(k, 1);
    perturb_i(i) = h(i);
    fi0 = nansum(feval(f, theta, varargin{:}));
    fip = nansum(feval(f, theta + perturb_i, varargin{:}));
    fim = nansum(feval(f, theta - perturb_i, varargin{:}));
    J(i, i) = (fip - 2 * fi0 + fim) / (h(i) ^ 2);
end
J = - J / N;

s = zeros(N, k);
for i = 1:k
    perturb_i    = zeros(k, 1);
    perturb_i(i) = h(i);
    fip = feval(f, theta + perturb_i, varargin{:});
    fim = feval(f, theta - perturb_i, varargin{:});
    s(:, i) = (fip - fim) / (2 * h(i));
end
I = s' * s / N;
