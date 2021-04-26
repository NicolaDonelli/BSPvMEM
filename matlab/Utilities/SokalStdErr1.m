function [StdErr, Tau_int] = SokalStdErr1(X)
% Ref. Kalli,M., Griffin,J., Walker,S.G. (2011) - Sampling mixture models.

n = size(X, 1);
m = size(X, 2);

StdErr = zeros(m,1);
Tau_int =  zeros(m,1);
for j = 1:m
    f = X(:, j);
    fbar = mean(f);
    C0 = var(f,1);

    [ACF, Lags] = autocorr(f, floor(n/10));
    ACF = ACF(2:end);
    Tau_int(j) = 0.5;
    M = 1;
    %M = 0;
    %while ((M < 3 * Tau_int(j)) && (M < length(ACF)))
    %    M = M + 1;
    %    Tau_int(j) = Tau_int(j) + ACF(M);
    %end
    while ((abs(ACF(M)) > 2 / sqrt(n)) && (M < length(ACF)))
        Tau_int(j) = Tau_int(j) + ACF(M);
        M = M + 1;
    end
    StdErr(j) = sqrt(1 / n * 2 * Tau_int(j) * C0);
end
