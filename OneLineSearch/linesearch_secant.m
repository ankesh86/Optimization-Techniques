function alpha = linesearch_secant(grad_file, x, d)
    % Load the gradient function
    grad = str2func(grad_file);

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
            return;
        end
        
        % Update the previous alpha values
        alpha0 = alpha1;
        alpha1 = alpha2;
    end
    
    % If maximum iterations are reached without convergence
    alpha = alpha1;
    warning('Maximum iterations reached without convergence');
end


