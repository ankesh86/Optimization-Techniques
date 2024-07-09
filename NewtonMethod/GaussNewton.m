% Generate noisy data
t = linspace(0, 10, 100)';
y_true = 2 * exp(0.3 * t);
y = y_true + 0.2 * randn(size(t));

% Residual function and Jacobian
residual = @(params) params(1) * exp(params(2) * t) - y;
jacobian = @(params) [exp(params(2) * t), params(1) * t .* exp(params(2) * t)];

% Gauss-Newton Method
params = [1; 0.1]; % Initial guess
max_iter = 100;
epsilon = 1e-4;

for iter = 1:max_iter
    J = jacobian(params);
    r = residual(params);
    delta = -(J' * J) \ (J' * r);
    params = params + delta;
    
    if norm(delta) < epsilon
        break;
    end
end

fprintf('Gauss-Newton for least-squares problem:\n');
fprintf('Parameters: [%f, %f]\n', params);
fprintf('Iterations: %d\n\n', iter);

% Levenberg-Marquardt Method for Least-Squares
params = [1; 0.1]; % Initial guess
lambda = 0.01;

for iter = 1:max_iter
    J = jacobian(params);
    r = residual(params);
    H = J' * J + lambda * eye(2);
    g = J' * r;
    delta = -H \ g;
    
    if norm(g) < epsilon
        break;
    end
    
    if norm(residual(params + delta)) < norm(r)
        params = params + delta;
        lambda = lambda / 10;
    else
        lambda = lambda * 10;
    end
end

fprintf('Levenberg-Marquardt for least-squares problem:\n');
fprintf('Parameters: [%f, %f]\n', params);
fprintf('Iterations: %d\n\n', iter);
