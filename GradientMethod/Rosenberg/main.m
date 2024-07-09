% Initial condition for Rosenbrock's function
x0 = [-2; 2];
epsilon = 1e-4;

% Run the steepest descent algorithm for Rosenbrock's function
[x, f_val, iterations] = steepest_descent_rosenbrock(x0, epsilon);

% Display results
fprintf('Number of iterations: %d\n', iterations);
fprintf('Final point: [%.10f, %.10f]\n', x);
fprintf('Objective function value at final point: %.10f\n', f_val);
