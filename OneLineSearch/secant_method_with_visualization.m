function secant_method_with_visualization
    % Define the function g(x)
    g = @(x) (2*x - 1)^2 + 4*(4 - 1024*x)^4;
    
    % Initial guesses
    x_prev = 0;
    x_curr = 1;
    
    % Tolerance
    epsilon = 1e-5;
    
    % Maximum number of iterations
    max_iter = 1000;
    
    % Iteration counter
    iter = 0;
    
    % Store iterations for plotting
    x_values = [x_prev, x_curr];
    g_values = [g(x_prev), g(x_curr)];
    
    % Secant method loop
    while iter < max_iter
        % Calculate the next approximation
        x_next = x_curr - g(x_curr) * (x_curr - x_prev) / (g(x_curr) - g(x_prev));
        
        % Store values for plotting
        x_values(end+1) = x_next;
        g_values(end+1) = g(x_next);
        
        % Check the stopping criterion
        if abs(x_next - x_curr) < abs(x_curr) * epsilon
            break;
        end
        
        % Update the previous and current values
        x_prev = x_curr;
        x_curr = x_next;
        
        % Increment the iteration counter
        iter = iter + 1;
    end
    
    % Display the results
    fprintf('Root found: x = %.10f\n', x_curr);
    fprintf('Value of g(x) at the root: g(x) = %.10f\n', g(x_curr));
    fprintf('Number of iterations: %d\n', iter);
    
    % Plot the function and iterations
    figure;
    fplot(g, [x_values(1) x_values(end)], 'LineWidth', 2);
    hold on;
    plot(x_values, g_values, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('x');
    ylabel('g(x)');
    title('Secant Method for Finding the Root of g(x) = 0');
    legend('g(x)', 'Iterations');
    grid on;
    hold off;
end
