% Define the Rosenbrock function
rosenbrock = @(x, y) 100 * (y - x.^2).^2 + (1 - x).^2;

% Create a grid of points
[x, y] = meshgrid(-2:0.1:2, -1:0.1:3);

% Evaluate the Rosenbrock function on the grid
z = rosenbrock(x, y);

% Plot the surface
figure;
surf(x, y, z);
xlabel('x_1');
ylabel('x_2');
zlabel('f(x_1, x_2)');
title('Rosenbrock Function Surface');
grid on;

% Plot the contour
figure;
contour(x, y, z, 50); % 50 contour levels
xlabel('x_1');
ylabel('x_2');
title('Rosenbrock Function Contour');
grid on;
