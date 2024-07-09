% Define the objective function
obj_func = @(x, y, z) (x - 4).^4 + (y - 3).^2 + 4*(z + 5).^4;

% Create a grid of x and y values
[X, Y] = meshgrid(-10:0.5:10, -10:0.5:10);

% Fix z at a specific value (e.g., z = 0)
Z = 0;

% Calculate function values for each point on the grid
F = obj_func(X, Y, Z);

% Create the surface plot
figure;
surf(X, Y, F);

% Customize the plot
xlabel('x');
ylabel('y');
zlabel('f(x,y,z=0)');
title('Surface Plot of f(x,y,z) = (x-4)^4 + (y-3)^2 + 4(z+5)^4 with z=0');
colorbar;

% Adjust the view for better visualization
view(-30, 30);

% Add a text annotation explaining the fixed z value
text(-10, -10, max(F(:)), 'z = 0', 'FontSize', 12, 'Color', 'red');

% Optional: Make the plot look nicer
lighting phong;
shading interp;