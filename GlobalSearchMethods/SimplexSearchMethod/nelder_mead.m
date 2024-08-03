% Objective function
f = @(x) (x(2) - x(1))^4 + 12 * x(1) * x(2) - x(1) + x(2) - 3;

% Initial simplex points
initial_points = [0.55, 0.7; -0.9, -0.5];

% Define the domain
lb = [-1, -1];
ub = [1, 1];

% Create a figure for plotting
figure;
hold on;
% Create a mesh grid and calculate function values for contour plot
[X1, X2] = meshgrid(linspace(-1, 1, 100), linspace(-1, 1, 100));
F = arrayfun(@(x1, x2) f([x1, x2]), X1, X2);
contour(X1, X2, F, 50); % Plot contour

colors = ['r', 'b']; % Different colors for different starting points

for i = 1:2
    % Starting point
    x0 = initial_points(i, :);
    
    % Initialize the points array for plotting the path
    points = x0;
    
    % Optimization using fminsearch (Nelder-Mead algorithm)
    options = optimset('Display', 'iter', 'OutputFcn', @(x, optimValues, state) outfunc(x, state, colors(i)));
    [x_opt, fval] = fminsearch(@(x) constrained_function(x, f, lb, ub), x0, options);
    
    fprintf('Starting point: [%f, %f]\n', x0(1), x0(2));
    fprintf('Optimized point: [%f, %f] with function value %f\n', x_opt(1), x_opt(2), fval);
end

hold off;

% Constrained function to enforce domain constraints
function y = constrained_function(x, f, lb, ub)
    x = max(min(x, ub), lb);
    y = f(x);
end

% Output function to capture and plot points
function stop = outfunc(x, state, color)
    stop = false;
    persistent points;
    
    if isequal(state, 'init')
        points = x; % Initialize points with the starting point
    elseif isequal(state, 'iter')
        points(end+1, :) = x; % Add new point to points array
        plot(points(:,1), points(:,2), [color, '-o']); % Plot points with lines
        drawnow;
    elseif isequal(state, 'done')
        % Final plot for the complete path
        plot(points(:,1), points(:,2), [color, '-o'], 'LineWidth', 2);
    end
end
