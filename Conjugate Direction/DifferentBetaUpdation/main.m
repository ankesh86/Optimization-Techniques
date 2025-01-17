% Define Rosenbrock function and gradient
rosenbrock = @(x) 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;
rosenbrock_grad = @(x) [-400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1)); 
                        200 * (x(2) - x(1)^2)];

% Initial condition
x0 = [-2; 2];

% Run Conjugate Gradient with Fletcher-Reeves update
[x_opt_FR, f_values_FR] = conjugate_gradient_with_beta_update(rosenbrock, rosenbrock_grad, x0, 100000, 'FR');

% Run Conjugate Gradient with Hestenes-Stiefel update
[x_opt_HS, f_values_HS] = conjugate_gradient_with_beta_update(rosenbrock, rosenbrock_grad, x0, 100000, 'HS');% Display results for Fletcher-Reeves update

[x_opt, f_value] = conjugate_gradient_with_beta_update(rosenbrock, rosenbrock_grad, x0, 100000,'');

disp('Fletcher-Reeves update:');
disp(['Optimal solution: ', num2str(x_opt_FR')]);
disp(['Optimal function value: ', num2str(rosenbrock(x_opt_FR))]);
%disp('Function values over iterations:');
%disp(f_values_FR');

% Display results for Hestenes-Stiefel update
disp('Hestenes-Stiefel update:');
disp(['Optimal solution: ', num2str(x_opt_HS')]);
disp(['Optimal function value: ', num2str(rosenbrock(x_opt_HS))]);
%disp('Function values over iterations:');
%disp(f_values_HS');

% Display results for Polak-Ribière formula update
disp('Polak-Ribière formula update:');
disp(['Optimal solution: ', num2str(x_opt')]);
disp(['Optimal function value: ', num2str(rosenbrock(x_opt))]);