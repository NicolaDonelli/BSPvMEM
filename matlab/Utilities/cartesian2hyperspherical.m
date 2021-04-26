function theta = cartesian2hyperspherical(u)

% u must be a unit length vector (i.e. a versor)
if ~(abs(norm(u) - 1)<1e-6)
    error('Error. Input vector must have unit norm.')
end
%u(find(abs(u) < 1e-6)) = 1e-6;
u(abs(u) < 1e-4) = 1e-4;
d = length(u);
theta = zeros(d - 1, 1);

%theta(1) = acos(u(1));
for i = 1:(d-2)
    if i == 1
        theta(i) = acos(u(i));
    else
        theta(i) = acos(u(i) / (u(i - 1) * tan(theta(i - 1))));
    end
end

% remember that arccos(.) belongs to [0,pi] and we want theta_(d-1)
% to stay in [0,2*pi].
% Hence for theta_(d-1) we have to choose between two possible
% alternatives that satisfies the condition 
% cos(t_d-1) = x_d-1/x_d-2 * tan(t_d-2)
% arcos(x_d-1/x_d-2 * tan(t_d-2)) and 2*pi - arcos(x_d-1/x_d-2 * tan(t_d-2))
% but only one of them satisfies also the other required condition:
% sin(t_d-1) = x_d/x_d-1 * cos(t_d-1)

if d == 2
    theta_end_1 = acos(u(1));
    theta_end_2 = 2*pi - theta_end_1;
    e1 = abs(u(2) - sin(theta_end_1));
    e2 = abs(u(2) - sin(theta_end_2));
else
    theta_end_1 = acos(u(d-1) / (u(d-2) * tan(theta(d-2))));
    theta_end_2 = 2*pi - theta_end_1;
    e1 = abs(u(d) * cos(theta_end_1) - u(d-1) * sin(theta_end_1));
    e2 = abs(u(d) * cos(theta_end_2) - u(d-1) * sin(theta_end_2));
end

% Since in the calculation of acos(.) there is an approximation error the
% second condition cannot be satisfied exactly. But we can still choose the
% alternative that minimize abs(sin(t_d-1) * x_d-1 - x_d * cos(t_d-1))

if e1 < e2
    theta(d - 1) = theta_end_1;
else
    theta(d - 1) = theta_end_2;
end