% Define the function for meshgrid
f_mesh = @(x1, x2) (x1.^4)/4 + (x2.^2)/2 - x1 .* x2 + x1 - x2;

% Create a meshgrid for plotting
[x1, x2] = meshgrid(-3:0.1:3, -3:0.1:3);

% Evaluate the function on the grid
z = f_mesh(x1, x2);

% Define the levels
levels = [-0.72, -0.6, -0.2, 0.5, 2];

% Plot the level sets
contour(x1, x2, z, levels);
xlabel('x1');
ylabel('x2');
title('Level Sets of f(x)');
colorbar;
