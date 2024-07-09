% Levenberg-Marquardt Method
x = [-2; 2];
lambda = 0.01;

for iter = 1:max_iter
    H = rosenbrock_hessian(x) + lambda * eye(2);
    g = rosenbrock_grad(x);
    dx = -H \ g;
    
    if norm(g) < epsilon
        break;
    end
    
    if rosenbrock(x + dx) < rosenbrock(x)
        x = x + dx;
        lambda = lambda / 10;
    else
        lambda = lambda * 10;
    end
end

fprintf('Levenberg-Marquardt for Rosenbrock function:\n');
fprintf('Solution: [%f, %f]\n', x);
fprintf('Iterations: %d\n\n', iter);
