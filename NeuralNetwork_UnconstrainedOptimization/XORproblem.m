% Initialization
eta = 10.0; % Step size
epochs = 500; % Number of epochs for training

% New initial weights and shift parameters
w11 = 0.1;
w12 = -0.2;
w21 = -0.3;
w22 = 0.4;
w31 = 0.5;
w32 = -0.6;
theta1 = 0.7;
theta2 = -0.8;
theta3 = 0.9;

% Training data for XOR problem
X = [0 0; 0 1; 1 0; 1 1];
y = [0; 1; 1; 0];

% Sigmoid activation function and its derivative
sigmoid = @(v) 1 / (1 + exp(-v));
sigmoid_derivative = @(v) sigmoid(v) * (1 - sigmoid(v));

% Track error over epochs
errors = zeros(epochs, 1);

% Training process
for epoch = 1:epochs
    total_error = 0;
    for i = 1:4
        % Forward propagation
        x_d = X(i, :)';
        y_d = y(i);

        v1 = w11 * x_d(1) + w12 * x_d(2) - theta1;
        v2 = w21 * x_d(1) + w22 * x_d(2) - theta2;
        h1 = sigmoid(v1);
        h2 = sigmoid(v2);
        v3 = w31 * h1 + w32 * h2 - theta3;
        y_hat = sigmoid(v3);

        % Compute error term at the output layer
        delta3 = (y_d - y_hat) * sigmoid_derivative(v3);

        % Compute error terms at the hidden layer
        delta1 = delta3 * w31 * sigmoid_derivative(v1);
        delta2 = delta3 * w32 * sigmoid_derivative(v2);

        % Update weights for hidden to output layer
        w31 = w31 + eta * delta3 * h1;
        w32 = w32 + eta * delta3 * h2;
        theta3 = theta3 - eta * delta3;

        % Update weights for input to hidden layer
        w11 = w11 + eta * delta1 * x_d(1);
        w12 = w12 + eta * delta1 * x_d(2);
        w21 = w21 + eta * delta2 * x_d(1);
        w22 = w22 + eta * delta2 * x_d(2);
        theta1 = theta1 - eta * delta1;
        theta2 = theta2 - eta * delta2;

        % Accumulate total error
        total_error = total_error + 0.5 * (y_d - y_hat)^2;
    end
    errors(epoch) = total_error;
end

% Print the final weights and shift parameters
fprintf('Final weights and shift parameters after training:\n');
fprintf('w11 = %.4f\n', w11);
fprintf('w12 = %.4f\n', w12);
fprintf('w21 = %.4f\n', w21);
fprintf('w22 = %.4f\n', w22);
fprintf('w31 = %.4f\n', w31);
fprintf('w32 = %.4f\n', w32);
fprintf('theta1 = %.4f\n', theta1);
fprintf('theta2 = %.4f\n', theta2);
fprintf('theta3 = %.4f\n', theta3);

% Tabulate the outputs of the trained network for the training input data
fprintf('Training input data and corresponding outputs of the trained network:\n');
for i = 1:4
    x_d = X(i, :)';
    y_d = y(i);

    % Forward propagation
    v1 = w11 * x_d(1) + w12 * x_d(2) - theta1;
    v2 = w21 * x_d(1) + w22 * x_d(2) - theta2;
    h1 = sigmoid(v1);
    h2 = sigmoid(v2);
    v3 = w31 * h1 + w32 * h2 - theta3;
    y_hat = sigmoid(v3);

    fprintf('Input: [%d, %d], Output: %.4f, Target: %d\n', x_d(1), x_d(2), y_hat, y_d);
end

% Plot the function implemented by the trained network
[x1, x2] = meshgrid(0:0.02:1, 0:0.02:1);
y_hat = zeros(size(x1));

for i = 1:size(x1, 1)
    for j = 1:size(x1, 2)
        % Forward propagation
        v1 = w11 * x1(i, j) + w12 * x2(i, j) - theta1;
        v2 = w21 * x1(i, j) + w22 * x2(i, j) - theta2;
        h1 = sigmoid(v1);
        h2 = sigmoid(v2);
        v3 = w31 * h1 + w32 * h2 - theta3;
        y_hat(i, j) = sigmoid(v3);
    end
end

figure;
mesh(x1, x2, y_hat);
xlabel('x1');
ylabel('x2');
zlabel('Output');
title('Function Implemented by the Trained Network for XOR Problem');

% Plot error over epochs
figure;
plot(1:epochs, errors);
xlabel('Epoch');
ylabel('Total Error');
title('Error Convergence Over Epochs');
