function [alpha, x_new, f_new] = linesearch_secant(grad_file, func_file, x, d)
    % Load the gradient function
    grad = str2func(grad_file);
    func = str2func(func_file);

    % Initial conditions
    alpha0 = 0;
    alpha1 = 0.001;
    
    % Tolerance
    epsilon = 1e-4;
    
    % Maximum number of iterations
    max_iter = 1000;
    
    % Secant method loop
    for iter = 1:max_iter
        % Calculate the directional derivative at the current alphas
        phi0 = d' * grad(x + alpha0 * d);
        phi1 = d' * grad(x + alpha1 * d);
        
        % Update alpha using the Secant method formula
        alpha2 = alpha1 - phi1 * (alpha1 - alpha0) / (phi1 - phi0);
        
        % Check the stopping criterion
        if abs(d' * grad(x + alpha2 * d)) <= epsilon * abs(d' * grad(x))
            alpha = alpha2;
            fprintf('Converged after %d iterations\n', iter);
            x_new = x + alpha * d;
            f_new = func(x_new);
            fprintf('Optimal step size alpha: %.10f\n', alpha);
            fprintf('New x value: %.10f\n', x_new);
            fprintf('Function value at new x: %.10f\n', f_new);
            return;
        end
        
        % Update the previous alpha values
        alpha0 = alpha1;
        alpha1 = alpha2;
    end
    
    % If maximum iterations are reached without convergence
    alpha = alpha1;
    x_new = x + alpha * d;
    f_new = func(x_new);
    warning('Maximum iterations reached without convergence');
end
