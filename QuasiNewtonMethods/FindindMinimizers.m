% Define the function and its gradient
f = @(x) x(1)^4/4 + x(2)^2/2 - x(1)*x(2) + x(1) - x(2);
grad_f = @(x) [x(1)^3 - x(2) + 1; x(2) - x(1) - 1];

% Initial conditions
x0_1 = [0; 0];
x0_2 = [1.5; 1];

% Parameters
max_iter = 100;

% Run DFP algorithm
[x_opt_1, f_values_1, x_values_1] = dfp_algorithm(f, grad_f, x0_1, max_iter);
[x_opt_2, f_values_2, x_values_2] = dfp_algorithm(f, grad_f, x0_2, max_iter);

% Display results
disp('Optimal solution with initial condition [0, 0]:');
disp(x_opt_1);
disp('Optimal function value:');
disp(f(x_opt_1));

disp('Optimal solution with initial condition [1.5, 1]:');
disp(x_opt_2);
disp('Optimal function value:');
disp(f(x_opt_2));

% Plot convergence
figure;
plot(1:max_iter, f_values_1, 'b-', 'DisplayName', '[0, 0]');
hold on;
plot(1:max_iter, f_values_2, 'r-', 'DisplayName', '[1.5, 1]');
xlabel('Iteration');
ylabel('Function Value');
title('Convergence of DFP Algorithm');
legend;
hold off;

% DFP algorithm
function [x_opt, f_values, x_values] = dfp_algorithm(f, grad_f, x0, max_iter)
    n = length(x0);
    H = eye(n);
    x = x0;
    
    f_values = zeros(max_iter, 1);
    x_values = zeros(max_iter, n);
    
    for k = 1:max_iter
        g = grad_f(x);
        d = -H * g;
        
        % Line search using a simple backtracking method
        alpha = 1;
        c = 1e-4;
        rho = 0.9;
        while f(x + alpha * d) > f(x) + c * alpha * g' * d
            alpha = rho * alpha;
        end
        
        % Update x
        x_new = x + alpha * d;
        
        % Update H
        s = x_new - x;
        y = grad_f(x_new) - g;
        H = H + (s * s') / (s' * y) - (H * y * y' * H) / (y' * H * y);
        
        % Store values
        x = x_new;
        f_values(k) = f(x);
        x_values(k, :) = x';
    end
    
    x_opt = x;
end
