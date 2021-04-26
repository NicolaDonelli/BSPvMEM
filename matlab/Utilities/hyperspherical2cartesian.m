function u = hyperspherical2cartesian(theta)

% u must be a unit length vector
d = length(theta) + 1;
u = zeros(d, 1);
u(1) = cos(theta(1));

for i = 2:(d-1)
    u(i) = u(i - 1) * cos(theta(i)) * tan(theta(i - 1));
end
u(d) = u(d - 1) * tan(theta(d - 1));
