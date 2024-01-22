% Load and prepare the data
pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Assuming the 2nd row is black foam and the 3rd row is car sponge
X = [pressure(2:3, :); vibration(2:3, :); temperature(2:3, :)]';

% Labels for classes (1 for black foam and 2 for car sponge)
labels = [ones(size(pressure, 2), 1); 2 * ones(size(pressure, 2), 1)];

% Standardize the data
X_std = (X - mean(X)) ./ std(X);

% Separate data by class
X_black_foam = X_std(labels == 1, :);
X_car_sponge = X_std(labels == 2, :);

% Calculate means
mean_black_foam = mean(X_black_foam);
mean_car_sponge = mean(X_car_sponge);
mean_overall = mean(X_std);

% Compute within-class scatter matrix
S_W = cov(X_black_foam) + cov(X_car_sponge);

% Compute between-class scatter matrix
mean_diff = mean_black_foam - mean_car_sponge;
S_B = (mean_diff' * mean_diff);

% Combine scatter matrices and compute eigenvectors and eigenvalues
S = inv(S_W) * S_B;
[eigenvectors, eigenvalues] = eig(S);

% Extract the diagonal of eigenvalues
eigenvalues = diag(eigenvalues);

% Sort eigenvalues and corresponding eigenvectors
[sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');
sorted_eigenvectors = eigenvectors(:, sort_index);

% Create a feature vector (largest eigenvector)
feature_vector = sorted_eigenvectors(:,1);

% Project the data onto the feature vector
Y_black_foam = X_black_foam * feature_vector;
Y_car_sponge = X_car_sponge * feature_vector;

% Plot the projections
figure;
plot(Y_black_foam, zeros(length(Y_black_foam), 1), 'bo');
hold on;
plot(Y_car_sponge, zeros(length(Y_car_sponge), 1), 'ro');
title('LDA Projection');
xlabel('Projected Axis');
legend('Black Foam', 'Car Sponge');
hold off;



