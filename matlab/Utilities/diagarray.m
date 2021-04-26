function [Out] = diagarray (S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates a matrix of diagonals from an array of square matrices
% INPUT:
% S:    tri-dimensional array with pages formed by square matrices
% OUTPUT:
% Out:  matrix whose columns are the main diagonals of the pages of S
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Out = zeros (size(S,1),size(S,3));
for i = 1:size(S,3)
    Out(:,i) = diag(S(:,:,i));
end
