function [x, f_val, iterations] = steepest_descent(x0, epsilon)
    max_iter = 10000;
    x = x0;
    iterations = 0;
    
    while norm(grad_func(x)) > epsilon
        d = -grad_func(x);
        [alpha, x, f_val] = linesearch_secant(@grad_func, @obj_func, x, d);
        iterations = iterations + 1;
        
        if iterations >= max_iter
            warning('Maximum iterations reached without convergence');
            break;
        end
    end
end
