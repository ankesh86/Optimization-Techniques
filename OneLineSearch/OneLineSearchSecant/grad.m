function g = grad(x)
    % Gradient of f(x) = (2x - 1)^2 + 4(4 - 1024x)^4
    g = 4 * (2*x - 1) - 16 * 1024 * (4 - 1024*x)^3;
end