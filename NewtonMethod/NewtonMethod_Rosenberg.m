% Rosenbrock function and its gradient and Hessian
rosenbrock = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
rosenbrock_grad = @(x) [-400*x(1)*(x(2)-x(1)^2) - 2*(1-x(1)); 200*(x(2)-x(1)^2)];
rosenbrock_hessian = @(x) [1200*x(1)^2 - 400*x(2) + 2, -400*x(1); -400*x(1), 200];

% Newton Method
x = [-2; 2];
epsilon = 1e-4;
max_iter = 10000;
iter = 0;

while norm(rosenbrock_grad(x)) > epsilon && iter < max_iter
    x = x - rosenbrock_hessian(x) \ rosenbrock_grad(x);
    iter = iter + 1;
end

fprintf('Newton Method for Rosenbrock function:\n');
fprintf('Solution: [%f, %f]\n', x);
fprintf('Iterations: %d\n\n', iter);
