%Define the objective function and its gradient ∇𝑓.
%Implement the secant method for line search.
%Implement the steepest descent algorithm using the secant method for the line search.
%Set the stopping criterion based on the norm of the gradient.
%Test the program with the initial condition provided.

% Initial condition
x0 = [-4, 5, 1]';
epsilon = 1e-6;

% Run the steepest descent algorithm
[x, f_val, iterations] = steepest_descent(x0, epsilon);

% Display results
fprintf('Number of iterations: %d\n', iterations);
fprintf('Final point: [%.10f, %.10f, %.10f]\n', x);
fprintf('Objective function value at final point: %.10f\n', f_val);
