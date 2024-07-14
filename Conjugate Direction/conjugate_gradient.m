function [x, f_values] = conjugate_gradient(func, grad, x0, max_iter)
    % Conjugate Gradient algorithm with secant method line search
    % func: objective function
    % grad: gradient function
    % x0: initial point
    % max_iter: maximum number of iterations

    x = x0;
    g = grad(x);
    d = -g;
    f_values = zeros(max_iter, 1);

    for k = 1:max_iter
        % Line search using secant method
        alpha = linesearch_secant(func, grad, x, d);
        
        % Update x
        x_new = x + alpha * d;
        
        % Compute new gradient
        g_new = grad(x_new);
        
        % Compute beta (Polak-Ribière formula)
        beta = max(0, g_new' * (g_new - g) / (g' * g));
        
        % Update search direction
        d = -g_new + beta * d;
        
        % Update x and g
        x = x_new;
        g = g_new;
        
        % Store function value
        f_values(k) = func(x);
        
        % Reinitialize search direction to negative gradient every 6 iterations
        if mod(k, 6) == 0
            d = -g;
        end
    end
    
    % Trim unused elements of f_values
    f_values = f_values(1:k);
end

function alpha = linesearch_secant(func, grad, x, d)
    % Secant method for line search
    % func: objective function
    % grad: gradient function
    % x: current point
    % d: search direction

    alpha0 = 0;
    alpha1 = 1;
    max_iter = 100;
    epsilon = 1e-6;

    for i = 1:max_iter
        g0 = grad(x + alpha0 * d)' * d;
        g1 = grad(x + alpha1 * d)' * d;
        
        if abs(g1) < epsilon
            alpha = alpha1;
            return;
        end
        
        alpha_new = alpha1 - g1 * (alpha1 - alpha0) / (g1 - g0);
        
        if abs(alpha_new - alpha1) < epsilon
            alpha = alpha_new;
            return;
        end
        
        alpha0 = alpha1;
        alpha1 = alpha_new;
    end
    
    alpha = alpha1;  % Return the last computed alpha if max_iter is reached
end