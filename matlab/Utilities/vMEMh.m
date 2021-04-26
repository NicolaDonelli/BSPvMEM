function h = vMEMh(x, eta, h_1, Str)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computes the time series of the conditional mean 
% 
% INPUT:
% x           : d * T
% eta         : is a vector that contains in this order (if present)
%                 - omega (dx1 vector)
%                 - B (d*d matrix)
%                 - A (d*d matrix)
%                 - Aneg (d*d matrix)
%                 - F (d*d matrix)
%                 - K (d*(l-1) matrix)
%                 - G (d*d*(l-1) array)
%                 - Gneg (d*d*(l-1) array)
%                   WHERE MATRICES AND ARRAYS ARE VECTORIZED
% h_1         : d * 1 vector of initial values of h
% Str         : Structure array describing the specification of the 
%                conditional mean
% OUTPUT:
% h           : d * T matrix of conditional means
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~ismatrix(x) || iscell(x) || isstruct(x) || ischar(x) || istable(x)
    error('The first argument, x, must be a numerical matrix.')
elseif isvector(x)
    error('The first argument, x, must have dimensions greater than 1.')
elseif size(x,1) > size(x,2)
    error('There must be more observations than variables.')
end

T = size(x,2);
d = size(x,1);

if ~isvector(eta) || isstruct(eta) || iscell(eta) || ischar(eta) || istable(eta)
    error('The second argument, eta, must be a numerical vector.')
elseif size(eta,1) > 1 %% We want eta to be a row vector
    eta = eta';
end

if ~isvector(h_1) || isstruct(h_1) || iscell(h_1) || ischar(h_1) || istable(h_1)
    error('The third argument, h_1, must be a numerical vector.')
elseif size(h_1,2) == size(x,1)
    h_1 = h_1';
elseif size(h_1,1) == size(x,1)
else
    error('Dimensions of h_1 do not match dimensions of x.')
end

if ~isstruct(Str)
    error('The fourth argument, Str, must be a structure array')
elseif ~isfield(Str,'isdiagB') || ~isfield(Str,'isdiagA') ...
        || ~isfield(Str,'isdiagAneg') || ~isfield(Str,'isdiagF') ...
        || ~isfield(Str,'isdiagG') || ~isfield(Str,'isdiagGneg') ...
        || ~isfield(Str,'x_lag') || ~isfield(Str,'x_neg') ...
        || ~isfield(Str,'TimeSteps')
    error('Str misses some required field.')
else
    if isempty(Str.TimeSteps)
        Str.isdiagG = false;
        Str.isdiagGneg = false;
    elseif ~isvector(Str.TimeSteps) || length(Str.TimeSteps) == 1 ...
            || length(Str.TimeSteps) > T || Str.TimeSteps(end) >= T  ...
            || Str.TimeSteps(1) ~= 0 || ~issorted(Str.TimeSteps)
        error('TimeSteps is misspecified.')
    end
    if ~islogical(Str.isdiagB) || ~islogical(Str.isdiagA) ...
       || ~islogical(Str.isdiagAneg) || ~islogical(Str.isdiagF) ...
       || ~islogical(Str.isdiagG) || ~islogical(Str.isdiagGneg)
        error('isdiagB, isdiagA, isdiagAneg, isdiagF, isdiagG, isdiagGneg must be logical')
    end
    if ~isempty(Str.x_lag) 
        if iscell(Str.x_lag) || ischar(Str.x_lag) || istable(Str.x_lag) || isstruct(Str.x_lag) || ~ismatrix(Str.x_lag)
            error('x_lag must be a numerical matrix.')
        elseif size(Str.x_lag) ~= size(x)
            error('x_lag must have the same size as x.')
        elseif Str.x_lag(:,1) ~= zeros(size(x,1),1);
            error('x_lag(:,1) must contain only zeros.')
        end
    end
    if ~isempty(Str.x_neg) 
        if iscell(Str.x_neg) || ischar(Str.x_neg) || istable(Str.x_neg) || isstruct(Str.x_neg) || ~ismatrix(Str.x_neg)
            error('x_neg must be a numerical matrix.')
        elseif size(Str.x_neg) ~= size(x)
            error('x_neg must have the same size as x.')
        end
    end
        
end

TimeSteps = Str.TimeSteps;
x_neg = Str.x_neg;
x_lag = Str.x_lag;
isdiagB = Str.isdiagB;
isdiagA = Str.isdiagA;
isdiagAneg = Str.isdiagAneg;
isdiagF = Str.isdiagF;
isdiagG = Str.isdiagG;
isdiagGneg = Str.isdiagGneg;
l = length(TimeSteps);

h = NaN * x;
h(:, 1) = h_1;


omega = eta(1:d)';
if isdiagB == 0 && isdiagA == 0 %%% both complete
    B     = reshape(eta(d + 1 : d + d^2),d,d);
    A     = reshape(eta(d + d^2 + 1 : d + 2*d^2),d,d);
elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
    B     = diag(reshape(eta(d + 1 : 2*d),d,1));
    A     = reshape(eta(2*d + 1 : 2*d + d^2),d,d);
elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
    B     = reshape(eta(d + 1 : d + d^2),d,d);
    A     = diag(reshape(eta(d + d^2 + 1 : 2*d + d^2),d,1));
else %%% both diagonal
    B     = diag(reshape(eta(d + 1 : 2*d),d,1));
    A     = diag(reshape(eta(2*d + 1 : 3*d),d,1));
end

if isempty(x_lag) && isempty(x_neg) && isempty(TimeSteps)
    if isdiagB == 0 && isdiagA == 0 %%% both complete
        if length(eta) ~= d + 2*d^2
            error('1.1 Eta is too long/short.')
        end
    elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
        if length(eta) ~= 2*d + d^2
            error('1.2 Eta is too long/short.')
        end
    elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
        if length(eta) ~= 2*d + d^2
            error('1.3 Eta is too long/short.')
        end
    else %%% both diagonal
        if length(eta) ~= 3*d
            error('1.4 Eta is too long/short.')
        end
    end
    if isdiagB == 0 && isdiagA == 0
        for t = 2:T
            h(:,t) = omega + B * h(:,t - 1) + A * x(:,t - 1);           
        end
    elseif isdiagB == 1 && isdiagA == 0
        for t = 2:T
            h(:,t) = omega + B * h(:,t - 1) + A * x(:,t - 1);           
        end
    elseif isdiagB == 0 && isdiagA == 1
        for t = 2:T
            h(:,t) = omega + B * h(:,t - 1) + A * x(:,t - 1);           
        end
    else
        for t = 2:T
            h(:,t) = omega + B * h(:,t - 1) + A * x(:,t - 1);           
        end
    end
    
elseif isempty(x_neg) && isempty(x_lag) && isempty(TimeSteps) == 0
    if isdiagG == 0
        if isdiagB == 0 && isdiagA == 0 %%% both complete
            if length(eta) ~= d + 2*d^2 + (l-1)*d + (l-1)*d^2
                error('2.1 Eta is too long/short.')
            end
        elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
            if length(eta) ~= 2*d + d^2 + (l-1)*d + (l-1)*d^2
                error('2.2 Eta is too long/short.')
            end
        elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
            if length(eta) ~= 2*d + d^2 + (l-1)*d + (l-1)*d^2
                error('2.3 Eta is too long/short.')
            end
        else %%% both diagonal
            if length(eta) ~= 3*d + (l-1)*d + (l-1)*d^2
                error('2.4 Eta is too long/short.')
            end
        end
        G = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - (l-1)*d + 1 : end  - (l-1)*d^2), d,l-1);
        for j = 1:l-1
            if (j==1)
               for t = 2:TimeSteps(2)
                   h(:,t) = omega                        ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1);
               end
            else
               for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                          ...
                           + B * h(:,t - 1)                 ...
                           + A * x(:,t - 1)                 ...
                           + K(:,j - 1)                     ...
                           + G(:,:,j - 1) * x(:,t - 1);        
               end      
            end
        end
         for t = (TimeSteps(l)+1):T
               h(:,t) = omega                         ...
                     + B * h(:,t - 1)                 ...
                     + A * x(:,t - 1)                 ...
                     + K(:,l - 1)                     ...
                     + G(:,:,l - 1) * x(:,t - 1);
         end
    else
        if isdiagB == 0 && isdiagA == 0 %%% both complete
            if length(eta) ~= d + 2*d^2 + (l-1)*d + (l-1)*d
                error('3.1 Eta is too long/short.')
            end
        elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
            if length(eta) ~= 2*d + d^2 + (l-1)*d + (l-1)*d
                error('3.2 Eta is too long/short.')
            end
        elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
            if length(eta) ~= 2*d + d^2 + (l-1)*d + (l-1)*d
                error('3.3 Eta is too long/short.')
            end
        else %%% both diagonal
            if length(eta) ~= 3*d + (l-1)*d + (l-1)*d
                error('3.4 Eta is too long/short.')
            end
        end
        G = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        K = reshape(eta(end  - (l-1)*d - (l-1)*d + 1 : end  - (l-1)*d), d,l-1);
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                       ...
                        + B * h(:,t - 1)                 ...
                        + A * x(:,t - 1)                 ...
                        + K(:,j - 1)                     ...
                        + G(:,j - 1) .* x(:,t - 1);        
                end     
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1);
        end
    end
    
elseif isempty(x_neg) && isempty(TimeSteps) && isempty(x_lag) == 0
    if isdiagF == 1
        if isdiagA == 0 && isdiagB == 0 %%% o,B,A,Fdiag
            if length(eta) ~= d + 2*d^2 + d
                error('4.1 Eta is too long/short.')
            else
                F = diag(eta(d + 2*d^2 + 1 : 2*d + 2*d^2));
            end
        elseif (isdiagA == 1 && isdiagB == 0) || (isdiagA == 0 && isdiagB == 1) %%% o,Bdiag,A,Fdiag or o,B,Adiag,Fdiag
            if length(eta) ~= 3*d + d^2
                error('4.2 Eta is too long/short.')
            else
                F = diag(eta(2*d + d^2 + 1 : 3*d + d^2));
            end
        else %%% o,Bdiag,Adiag,Fdiag
            if length(eta) ~= 4*d
                error('4.3 Eta is too long/short.')
            else
                F = diag(eta(3*d + 1 : 4*d));
            end
        end
    else 
        if isdiagA == 0 && isdiagB == 0
            if length(eta) ~= d + 3*d^2
                error('5.1 Eta is too long/short.')
            else
                F = reshape(eta(d + 2*d^2 + 1 : d + 3*d^2),d,d);
            end
        elseif (isdiagA == 1 && isdiagB == 0) || (isdiagA == 0 && isdiagB == 1)
            if length(eta) ~= 2*d + 2*d^2
                error('5.2 Eta is too long/short.')
            else
                F = reshape(eta(2*d + d^2 + 1 : 2*d + 2*d^2),d,d);
            end
        else
            if length(eta) ~= 3*d + d^2
                error('5.3 Eta is too long/short.')
            else
                F = reshape(eta(3*d + 1 : 3*d + d^2),d,d);
            end
        end
    end
    for t = 2:T
        h(:,t) = omega                  ...
            + B * h(:,t - 1)            ...
            + A * x(:,t - 1)            ...
            + F * x_lag(:,t - 1);       ...
    end
        

elseif isempty(x_lag) && isempty(TimeSteps) && isempty(x_neg) == 0
    if isdiagAneg == 0
         if isdiagB == 0 && isdiagA == 0 %%% both complete
             if length(eta) ~= d + 2*d^2 + d^2
                 error('6.1 Eta is too long/short.')
             end
         elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
             if length(eta) ~= 2*d + d^2 + d^2
                 error('6.2 Eta is too long/short.')
             end
         elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
             if length(eta) ~= 2*d + d^2 + d^2
                 error('6.3 Eta is too long/short.')
             end
         else %%% both diagonal
             if length(eta) ~= 3*d + d^2
                 error('6.4 Eta is too long/short.')
             end
         end
        Aneg  = reshape(eta(end  - d^2 + 1 : end ),d,d);
    else
         if isdiagB == 0 && isdiagA == 0 %%% both complete
             if length(eta) ~= d + 2*d^2 + d
                 error('7.1 Eta is too long/short.')
             end
         elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
             if length(eta) ~= 2*d + d^2 + d
                 error('7.2 Eta is too long/short.')
             end
         elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
             if length(eta) ~= 2*d + d^2 + d
                 error('7.3 Eta is too long/short.')
             end
         else %%% both diagonal
             if length(eta) ~= 3*d + d
                 error('7.4 Eta is too long/short.')
             end
         end        
        Aneg  = diag(reshape(eta(end  - d + 1 : end ),d,1));
    end
    for t = 2:T
        h(:,t) = omega                      ...
                + B * h(:,t - 1)            ...
                + A * x(:,t - 1)            ...
                + Aneg * x_neg(:,t - 1);    ...
    end

elseif isempty(TimeSteps) && isempty(x_lag) == 0 && isempty(x_neg) == 0
    if isdiagF == 0  %%% F complete
        F = reshape(eta(end  - d^2 + 1 : end ),d,d);
        if isdiagAneg == 0 %%% Aneg complete F complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + 2*d^2
                     error('8.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + 2*d^2
                    error('8.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + 2*d^2
                     error('8.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + 2*d^2
                     error('8.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - d^2 - d^2 + 1 : end  - d^2),d,d);
        else %%% Aneg diagonal F complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + d^2
                     error('9.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + d^2
                    error('9.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + d^2
                     error('9.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + d^2
                     error('9.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end - d - d^2 + 1 : end - d^2));
        end
    else %%% F diagonal
        F = diag(eta(end  - d + 1 : end ));
        if isdiagAneg == 0 %%% Aneg complete F diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + d
                     error('10.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + d
                    error('10.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + d
                     error('10.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + d
                     error('10.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - d - d^2 + 1 : end  - d),d,d);
        else %% Aneg diagonal F diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + d
                     error('11.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + d
                    error('11.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + d
                     error('11.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + d
                     error('11.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end - d - d + 1 : end - d));
        end        
    end
    for t = 2:T
        h(:,t) = omega                  ...
            + B * h(:,t - 1)            ...
            + A * x(:,t - 1)            ...
            + Aneg * x_neg(:,t - 1)     ...
            + F * x_lag(:,t - 1);       ...
    end

elseif isempty(x_lag) && isempty(x_neg) == 0 && isempty(TimeSteps) == 0
    if isdiagG == 0 && isdiagGneg == 0 
        Gneg = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1); 
        G = reshape(eta(end  - 2*(l-1)*d^2 + 1 : end  - (l-1)*d^2), d,d,l-1); 
        K = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d + 1 : end  - 2*(l-1)*d^2), d,l-1); 
        if isdiagAneg == 0 %%% Aneg complete, G complete, Gneg complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('12.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                    error('12.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('12.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('12.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d^2 + 1 : end  - 2*(l-1)*d^2 - (l-1)*d), d,d); 
        else %%% Aneg diag, G complete, Gneg complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('13.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                    error('13.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('13.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                     error('13.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d + 1 : end  - 2*(l-1)*d^2 - (l-1)*d));
        end
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + K(:,j - 1)                     ...
                            + G(:,:,j - 1) * x(:,t - 1)      ...
                            + Gneg(:,:,j - 1) * x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + K(:,l - 1)                     ...
                    + G(:,:,l - 1) * x(:,t - 1)      ...
                    + Gneg(:,:,l - 1) * x_neg(:,t - 1);
        end
    elseif isdiagG == 0 && isdiagGneg == 1
        Gneg = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        G = reshape(eta(end  - (l-1)*d - (l-1)*d^2 + 1 : end  - (l-1)*d), d,d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d + 1 : end  - (l-1)*d - (l-1)*d^2), d,l-1);
        if isdiagAneg == 0 %%% Aneg complete, G complete, Gneg diag
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('13.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                    error('13.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('13.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('13.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d,d);
        else %%% Aneg diagonal, G complete, Gneg diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('14.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                    error('14.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('14.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                     error('14.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
        end            
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + K(:,j - 1)                     ...
                            + G(:,:,j - 1) * x(:,t - 1)      ...
                            + Gneg(:,j - 1) .* x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + K(:,l - 1)                     ...
                    + G(:,:,l - 1) * x(:,t - 1)      ...
                    + Gneg(:,l - 1) .* x_neg(:,t - 1);
        end
    elseif isdiagG == 1 && isdiagGneg == 0
        Gneg = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1);
        G = reshape(eta(end - (l-1)*d^2 - (l-1)*d  + 1 : end  - (l-1)*d^2), d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d + 1 : end  - (l-1)*d - (l-1)*d^2), d,l-1);
        if isdiagAneg == 0 %%% Aneg complete, G diagonal, Gneg complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('15.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                    error('15.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('15.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('15.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d,d);
        else %%% Aneg complete, G diagonal, Gneg complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('16.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                    error('16.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('16.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                     error('16.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
        end            
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + K(:,j - 1)                     ...
                            + G(:,j - 1) .* x(:,t - 1)       ...
                            + Gneg(:,:,j - 1) * x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1)       ...
                    + Gneg(:,:,l - 1) * x_neg(:,t - 1);
        end
    else
        Gneg = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        G = reshape(eta(end  - 2*(l-1)*d  + 1 : end  - (l-1)*d), d,l-1);
        K = reshape(eta(end  - 3*(l-1)*d + 1 : end  - 2*(l-1)*d), d,l-1);
        if isdiagAneg == 0 %%% Aneg complete, G diagonal, Gneg diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                     error('17.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                    error('17.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                     error('17.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                     error('17.4 Eta is too long/short.')
                 end
            end
            Aneg  = reshape(eta(end  - 3*(l-1)*d - d^2 + 1 : end  - 3*(l-1)*d), d,d);
        else %%% Aneg complete, G diagonal, Gneg diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                     error('18.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                    error('18.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                     error('18.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d + (l-1)*d
                     error('18.4 Eta is too long/short.')
                 end
            end
            Aneg  = diag(eta(end  - (l-1)*d - 2*(l-1)*d - d + 1 : end  - (l-1)*d - 2*(l-1)*d));
        end            
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + K(:,j - 1)                     ...
                            + G(:,j - 1) .* x(:,t - 1)       ...
                            + Gneg(:,j - 1) .* x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1)       ...
                    + Gneg(:,l - 1) .* x_neg(:,t - 1);
        end
    end
        
elseif isempty(x_neg) && isempty(x_lag) == 0 && isempty(TimeSteps) == 0
    if isdiagG == 0
        if isdiagF == 0 %%% F complete, G complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d^2
                     error('19.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2
                    error('19.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2
                     error('19.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d^2
                     error('19.4 Eta is too long/short.')
                 end
            end
            F = reshape(eta(end  - (l-1)*d^2 - (l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - (l-1)*d) , d, d);
        else  %%% F diagonal, G complete
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d^2
                     error('20.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2
                    error('20.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d^2
                     error('20.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d^2
                     error('20.4 Eta is too long/short.')
                 end
            end
            F = diag(eta(end  - (l-1)*d^2 - (l-1)*d - d + 1 : end  - (l-1)*d^2 - (l-1)*d));
        end
        G = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - (l-1)*d + 1 : end  - (l-1)*d^2), d,l-1);
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,:,j - 1) * x(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + F * x_lag(:,t - 1)             ...
                    + K(:,l - 1)                     ...
                    + G(:,:,l - 1) * x(:,t - 1);
        end 
    else 
        if isdiagF == 0 %%% F complete, G diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d^2 + (l-1)*d + (l-1)*d
                     error('21.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d
                    error('21.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d^2 + (l-1)*d + (l-1)*d
                     error('21.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d^2 + (l-1)*d + (l-1)*d
                     error('21.4 Eta is too long/short.')
                 end
            end
            F = reshape(eta(end  - 2*(l-1)*d - d^2 + 1 : end  - 2*(l-1)*d), d, d);
        else  %%% F diagonal, G diagonal
            if isdiagB == 0 && isdiagA == 0 %%% both complete
                if length(eta) ~= d + 2*d^2 + d + (l-1)*d + (l-1)*d
                     error('22.1 Eta is too long/short.')
                end
            elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d
                    error('22.2 Eta is too long/short.')
                 end
            elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                 if length(eta) ~= 2*d + d^2 + d + (l-1)*d + (l-1)*d
                     error('22.3 Eta is too long/short.')
                 end
            else %%% both diagonal
                 if length(eta) ~= 3*d + d + (l-1)*d + (l-1)*d
                     error('22.4 Eta is too long/short.')
                 end
            end
            F = diag(eta(end  - 2*(l-1)*d - d + 1 : end  - 2*(l-1)*d)');
        end
        G = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        K = reshape(eta(end  - 2*(l-1)*d + 1 : end  - (l-1)*d), d,l-1);        
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,j - 1) .* x(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + F * x_lag(:,t - 1)             ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1);
        end
    end        
elseif isempty(TimeSteps) == 0  && isempty(x_lag) == 0 && isempty(x_neg) == 0
    if isdiagG == 0 && isdiagGneg == 0
        Gneg = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1);
        G = reshape(eta(end  - 2*(l-1)*d^2 + 1 : end  - (l-1)*d^2), d,d,l-1);
        K = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d + 1 : end  - 2*(l-1)*d^2), d,l-1);
        if isdiagAneg == 0
            if isdiagF == 0 %%% Aneg complete, F complete, G complete, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('23.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('23.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('23.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('23.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d^2 + 1 : end  - 2*(l-1)*d^2 - (l-1)*d), d, d);
                Aneg  = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d^2 - d^2 + 1 : end  - 2*(l-1)*d^2 - (l-1)*d - d^2), d,d); 
            else %%% Aneg complete, F diag, G complete, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('24.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('24.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('24.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('24.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d + 1 : end  - 2*(l-1)*d^2 - (l-1)*d));
                Aneg  = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d^2 - d + 1 : end  - 2*(l-1)*d^2 - (l-1)*d - d), d,d); 
            end
        else
            if isdiagF == 0 %%% Aneg diag, F complete, G complete, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('25.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('25.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('25.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('25.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d^2 + 1 : end  - 2*(l-1)*d^2 - (l-1)*d), d, d);
                Aneg  = diag(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d - d^2 + 1 : end  - 2*(l-1)*d^2 - (l-1)*d - d^2)); 
            else %%% Aneg diag, F diag, G complete, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('26.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                        error('26.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('26.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d^2
                         error('26.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d + 1 : end  - 2*(l-1)*d^2 - (l-1)*d));
                Aneg  = diag(eta(end  - 2*(l-1)*d^2 - (l-1)*d - d - d + 1 : end  - 2*(l-1)*d^2 - (l-1)*d - d)); 
            end
        end
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1)      ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,:,j - 1) * x(:,t - 1)      ...
                            + Gneg(:,:,j - 1) * x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + F * x_lag(:,t - 1)             ...
                    + K(:,l - 1)                     ...
                    + G(:,:,l - 1) * x(:,t - 1)      ...
                    + Gneg(:,:,l - 1) * x_neg(:,t - 1);
        end
    elseif isdiagG == 0 && isdiagGneg == 1
        Gneg = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        G = reshape(eta(end  - (l-1)*d - (l-1)*d^2 + 1 : end  - (l-1)*d), d,d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d + 1 : end  - (l-1)*d - (l-1)*d^2), d,l-1);
        if isdiagAneg == 0
            if isdiagF == 0 %%% Aneg complete, F complete, G complete, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('27.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('27.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('27.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('27.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d, d);
                Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d^2), d,d); 
            else %%% Aneg complete, F diag, G complete, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('28.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('28.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('28.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('28.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
                Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d), d,d); 
            end
        else
            if isdiagF == 0 %%% Aneg diag, F complete, G complete, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('29.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('29.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('29.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d^2 + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('29.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d, d);
                Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d^2)); 
            else %%% Aneg diag, F diag, G complete, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('30.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                        error('30.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('30.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d + (l-1)*d + (l-1)*d^2 + (l-1)*d
                         error('30.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
                Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d)); 
            end
        end
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1)      ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,:,j - 1) * x(:,t - 1)      ...
                            + Gneg(:,j - 1) .* x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + F * x_lag(:,t - 1)             ... 
                    + K(:,l - 1)                     ...
                    + G(:,:,l - 1) * x(:,t - 1)      ...
                    + Gneg(:,l - 1) .* x_neg(:,t - 1);
        end
    elseif isdiagG == 1 && isdiagGneg == 0
        Gneg = reshape(eta(end  - (l-1)*d^2 + 1 : end ), d,d,l-1);
        G = reshape(eta(end - (l-1)*d^2 - (l-1)*d  + 1 : end  - (l-1)*d^2), d,l-1);
        K = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d + 1 : end  - (l-1)*d - (l-1)*d^2), d,l-1);
        if isdiagAneg == 0
            if isdiagF == 0 %%% Aneg complete, F complete, G diag, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('31.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('31.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('31.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('31.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d, d);
                Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d^2), d,d); 
            else %%% Aneg complete, F diag, G diag, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('32.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('32.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('32.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('32.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
                Aneg  = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d), d,d); 
            end
        else
            if isdiagF == 0 %%% Aneg diag, F complete, G diag, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('33.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('33.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('33.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('33.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d), d, d);
                Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d - d^2 + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d^2)); 
            else %%% Aneg diag, F diag, G diag, Gneg complete
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('34.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                        error('34.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('34.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d + (l-1)*d + (l-1)*d + (l-1)*d^2
                         error('34.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d));
                Aneg  = diag(eta(end  - (l-1)*d^2 - 2*(l-1)*d - d - d + 1 : end  - (l-1)*d^2 - 2*(l-1)*d - d)); 
            end
        end
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1)      ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,j - 1) .* x(:,t - 1)       ...
                            + Gneg(:,:,j - 1) * x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + F * x_lag(:,t - 1)             ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1)       ...
                    + Gneg(:,:,l - 1) * x_neg(:,t - 1);
        end
    else
        Gneg = reshape(eta(end  - (l-1)*d + 1 : end ), d,l-1);
        G = reshape(eta(end  - 2*(l-1)*d  + 1 : end  - (l-1)*d), d,l-1); 
        K = reshape(eta(end  - 3*(l-1)*d + 1 : end  - 2*(l-1)*d), d,l-1);
        if isdiagAneg == 0
            if isdiagF == 0 %%% Aneg complete, F complete, G diag, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                        error('35.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                        error('35.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                         error('35.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                         error('35.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - 3*(l-1)*d - d^2 + 1 : end  - 3*(l-1)*d), d, d);
                Aneg  = reshape(eta(end  - 3*(l-1)*d - d^2 - d^2 + 1 : end  - 3*(l-1)*d - d^2), d,d); 
            else %%% Aneg complete, F diag, G diag, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                        error('36.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                        error('36.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                         error('36.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d^2 + d + (l-1)*d + (l-1)*d + (l-1)*d
                         error('36.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - 3*(l-1)*d - d + 1 : end  - 3*(l-1)*d));
                Aneg  = reshape(eta(end  - 3*(l-1)*d - d^2 - d + 1 : end  - 3*(l-1)*d - d), d,d); 
            end
        else
            if isdiagF == 0 %%% Aneg diag, F complete, G diag, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                        error('37.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                        error('37.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                         error('37.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d^2 + (l-1)*d + (l-1)*d + (l-1)*d
                         error('37.4 Eta is too long/short.')
                     end
                end
                F = reshape(eta(end  - 3*(l-1)*d - d^2 + 1 : end  - 3*(l-1)*d), d, d);
                Aneg  = diag(eta(end  - 3*(l-1)*d - d - d^2 + 1 : end  - 3*(l-1)*d - d^2)); 
            else %%% Aneg diag, F diag, G diag, Gneg diag
                if isdiagB == 0 && isdiagA == 0 %%% both complete
                    if length(eta) ~= d + 2*d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d
                        error('38.1 Eta is too long/short.')
                    end
                elseif isdiagB == 1 && isdiagA == 0 %%% B diagonal A complete
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d
                        error('38.2 Eta is too long/short.')
                     end
                elseif isdiagB == 0 && isdiagA == 1 %%% B complete A diagonal
                     if length(eta) ~= 2*d + d^2 + d + d + (l-1)*d + (l-1)*d + (l-1)*d
                         error('38.3 Eta is too long/short.')
                     end
                else %%% both diagonal
                     if length(eta) ~= 3*d + d + d + (l-1)*d + (l-1)*d + (l-1)*d
                         error('38.4 Eta is too long/short.')
                     end
                end
                F = diag(eta(end  - 3*(l-1)*d - d + 1 : end  - 3*(l-1)*d));
                Aneg  = diag(eta(end  - 3*(l-1)*d - d - d + 1 : end  - 3*(l-1)*d - d)); 
            end
        end
        for j = 1:l-1
            if (j==1)
                for t = 2:TimeSteps(2)
                    h(:,t) = omega                       ...
                            + B * h(:,t - 1)             ...
                            + A * x(:,t - 1)             ...
                            + Aneg * x_neg(:,t - 1)      ...
                            + F * x_lag(:,t - 1);
                end
            else
                for t = (TimeSteps(j)+1):TimeSteps(j+1)
                    h(:,t) = omega                           ...
                            + B * h(:,t - 1)                 ...
                            + A * x(:,t - 1)                 ...
                            + Aneg * x_neg(:,t - 1)          ...
                            + F * x_lag(:,t - 1)             ...
                            + K(:,j - 1)                     ...
                            + G(:,j - 1) .* x(:,t - 1)       ...
                            + Gneg(:,j - 1) .* x_neg(:,t - 1);
                end      
            end
        end
        for t = (TimeSteps(l)+1):T
            h(:,t) = omega                           ...
                    + B * h(:,t - 1)                 ...
                    + A * x(:,t - 1)                 ...
                    + Aneg * x_neg(:,t - 1)          ...
                    + F * x_lag(:,t - 1)             ...
                    + K(:,l - 1)                     ...
                    + G(:,l - 1) .* x(:,t - 1)       ...
                    + Gneg(:,l - 1) .* x_neg(:,t - 1);
        end
    end    
end