% Initial weights
w11 = 0.1;
w12 = 0.3;
w21 = 0.3;
w22 = 0.4;
w31 = 0.4;
w32 = 0.6;

% Training data
X_d = [0; 1];
y_d = 1;

% Learning rate
eta = 50;

% Sigmoid activation function
sigmoid = @(v) 1 / (1 + exp(-v));
sigmoid_derivative = @(v) sigmoid(v) * (1 - sigmoid(v));

% Forward propagation
v1 = w11 * X_d(1) + w12 * X_d(2);
v2 = w21 * X_d(1) + w22 * X_d(2);
h1 = sigmoid(v1);
h2 = sigmoid(v2);
v3 = w31 * h1 + w32 * h2;
y_hat = sigmoid(v3);

% Compute error term at the output layer
delta3 = (y_d - y_hat) * sigmoid_derivative(v3);

% Update weights for hidden to output layer
w31_new = w31 + eta * delta3 * h1;
w32_new = w32 + eta * delta3 * h2;

% Compute error terms at the hidden layer
delta1 = delta3 * w31 * sigmoid_derivative(v1);
delta2 = delta3 * w32 * sigmoid_derivative(v2);

% Update weights for input to hidden layer
w11_new = w11 + eta * delta1 * X_d(1);
w12_new = w12 + eta * delta1 * X_d(2);
w21_new = w21 + eta * delta2 * X_d(1);
w22_new = w22 + eta * delta2 * X_d(2);

% Display updated weights
fprintf('Updated weights after one iteration of backpropagation:\n');
fprintf('w11: %.4f\n', w11_new);
fprintf('w12: %.4f\n', w12_new);
fprintf('w21: %.4f\n', w21_new);
fprintf('w22: %.4f\n', w22_new);
fprintf('w31: %.4f\n', w31_new);
fprintf('w32: %.4f\n', w32_new);
