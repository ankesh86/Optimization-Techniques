% Rosenbrock function and its gradient
rosenbrock = @(x) 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;
rosenbrock_grad = @(x) [-400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1)); 
                        200 * (x(2) - x(1)^2)];

% Initial condition
x0 = [-2; 2];
max_iter = 100000;

% Run Quasi-Newton with different methods
methods = {'BFGS', 'SR1', 'DFP', 'ApproxInvHessian'};
results = cell(length(methods), 2);

for i = 1:length(methods)
    [x_opt, f_values] = quasi_newton(rosenbrock, rosenbrock_grad, x0, max_iter, methods{i});
    results{i, 1} = x_opt;
    results{i, 2} = f_values;
end

% Display results
for i = 1:length(methods)
    method = methods{i};
    x_opt = results{i, 1};
    f_values = results{i, 2};
    
    disp(['Optimal solution (', method, '):']);
    disp(x_opt);
    disp(['Optimal function value (', method, '):']);
    disp(rosenbrock(x_opt));
    
    % Plot convergence
    figure;
    semilogy(f_values - rosenbrock([1; 1]), 'b-');
    xlabel('Iteration');
    ylabel('|f(x) - f(x*)|');
    title(['Convergence of Quasi-Newton Method (', method, ')']);
end
