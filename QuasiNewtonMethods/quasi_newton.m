function [x_opt, f_values] = quasi_newton(func, grad, x0, max_iter, method)
    x = x0;
    n = length(x0);
    B = eye(n); % Initial approximation of Hessian inverse
    
    f_values = zeros(max_iter, 1);
    
    for k = 1:max_iter
        g = grad(x);
        d = -B * g; % Compute search direction
        
        % Line search using secant method
        alpha = secant_line_search(func, grad, x, d);
        
        % Update x
        x_new = x + alpha * d;
        
        % Compute gradient difference
        g_new = grad(x_new);
        y = g_new - g;
        s = x_new - x;
        
        % Update B
        if strcmp(method, 'BFGS')
            % BFGS update
            rho = 1 / (y' * s);
            V = eye(n) - rho * s * y';
            B = V' * B * V + rho * (s * s');
        elseif strcmp(method, 'SR1')
            % SR1 update
            if abs(y' * s) > eps
                Bs = B * s;
                B = B + (y - Bs) * (y - Bs)' / ((y - Bs)' * s);
            end
        elseif strcmp(method, 'DFP')
            % DFP update
            rho = 1 / (y' * s);
            B = B + rho * (s * s') - (B * y) * (y' * B) / (y' * B * y);
        elseif strcmp(method, 'ApproxInvHessian')
            % Approximating Inverse Hessian update (simplified BFGS)
            B = B + (y * y') / (y' * s);
        else
            error('Invalid method');
        end
        
        % Reinitialize the update direction to the negative gradient every six iterations
        if mod(k, 6) == 0
            B = eye(n);
        end
        
        % Update x and store function value
        x = x_new;
        f_values(k) = func(x);
        
        % Check for convergence
        if norm(g_new) < 1e-6
            f_values = f_values(1:k);
            x_opt = x;
            return;
        end
    end
    
    x_opt = x;
end

function alpha = secant_line_search(func, grad, x, d)
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