function PP = PostProcessing (mbar, n, isdiagB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Post-Processing transformation
% INPUT:
% mbar:     estimate of the mean of the DPM
% n:        length of the vector of parameters
% isdiagB:  Flag that indicates if B is diagonal or not
% OUTPUT:s
% PP:       Post-Processing transformation vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isvector(mbar) || isstruct(mbar) || iscell(mbar) || ischar(mbar) || istable(mbar)
    error('The first argument, mbar, must be a numerical vector.')
elseif size(mbar,2) > 1 %% We want mbar to be a column vector
    mbar = mbar';
end

if ~islogical(isdiagB)
    error('The third argument must be logical')
end

d = length(mbar);

if isdiagB == 0
    PP = [mbar; ones(d^2,1); repmat(mbar, (n - d - d^2) / d, 1)];
else
    PP = [mbar; ones(d,1); repmat(mbar, (n - d - d) / d, 1)];
end