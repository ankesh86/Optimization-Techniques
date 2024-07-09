x = 2; % Starting point
d = -1; % Search direction
[alpha, x_new, f_new] = linesearch_secant('grad', 'func', x, d);

