function theta_v = CorrMat2ThetaVec(R)

d = size(R, 1);
%if ~(diag(R) == ones(d,1))
%    error('Error. \nDiagonal elements must be all equal to 1.')
%end
U = chol(R);

theta_v = zeros(d, d);
for j = 2:d
    theta_v(1:(j-1), j) = cartesian2hyperspherical(U(1:j, j));
end
theta_v(theta_v==0) = []; %row vector
theta_v = theta_v'; %column vector
