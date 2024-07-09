x = 2; % Starting point
d = -1; % Search direction
alpha = linesearch_secant('grad', x, d);
fprintf('Optimal step size alpha: %.10f\n', alpha);