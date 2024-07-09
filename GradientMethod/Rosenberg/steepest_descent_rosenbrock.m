function [x, f_val, iterations] = steepest_descent_rosenbrock(x0, epsilon)
    max_iter = 10000;
    x = x0;
    iterations = 0;
    
    while norm(rosenbrock_grad(x)) > epsilon
        d = -rosenbrock_grad(x);
        [alpha, x, f_val] = linesearch_secant(@rosenbrock_grad, @rosenbrock_func, x, d);
        iterations = iterations + 1;
        
        if iterations >= max_iter
            warning('Maximum iterations reached without convergence');
            break;
        end
    end
end
