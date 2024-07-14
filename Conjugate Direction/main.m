% Rosenbrock function and its gradient
rosenbrock = @(x) 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;
rosenbrock_grad = @(x) [-400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1)); 
                        200 * (x(2) - x(1)^2)];

% Initial condition
x0 = [-2; 2];

% Run the conjugate gradient algorithm
[x_opt, f_values] = conjugate_gradient(rosenbrock, rosenbrock_grad, x0, 100);

% Display results
disp('Optimal solution:');
disp(x_opt);
disp('Optimal function value:');
disp(rosenbrock(x_opt));

% Plot convergence
figure;
semilogy(f_values - rosenbrock([1; 1]), 'b-');
xlabel('Iteration');
ylabel('|f(x) - f(x*)|');
title('Convergence of Conjugate Gradient Method');