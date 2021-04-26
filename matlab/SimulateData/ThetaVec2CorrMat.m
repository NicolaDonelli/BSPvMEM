function R = ThetaVec2CorrMat(theta_v)

if mod((1 + sqrt(1 + 8 * length(theta_v))) / 2 , 1) ~= 0
    error ('Error. Input vector has not the correct length.')
end

d = (1 + sqrt(1 + 8 * length(theta_v))) / 2;
Theta_Mat = triu(ones(d,d),1);
Theta_Mat(Theta_Mat==1) = theta_v; 
U = triu(ones(d,d));
for j = 2:d
    U(1:j, j) = hyperspherical2cartesian(Theta_Mat(Theta_Mat(:,j) ~=0,j));
end
R = U' * U;
