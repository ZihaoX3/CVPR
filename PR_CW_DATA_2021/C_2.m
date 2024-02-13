%3D and 1D projection

% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');

pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Initialize matrices with three columns for Pressure, Vibration, and Temperature
X_black_foam = zeros(size(pressure, 2), 3);
X_car_sponge = zeros(size(pressure, 2), 3);

% Extract data for black foam and car sponge
for i = 1 : size(pressure, 2)
    X_black_foam(i, 1) = pressure(2, i); % Pressure
    X_black_foam(i, 2) = vibration(2, i); % Vibration
    X_black_foam(i, 3) = temperature(2, i); % Temperature

    X_car_sponge(i, 1) = pressure(3, i); % Pressure
    X_car_sponge(i, 2) = vibration(3, i); % Vibration
    X_car_sponge(i, 3) = temperature(3, i); % Temperature
end


% Standardization
X_black_foam = (X_black_foam - mean(X_black_foam)) ./ std(X_black_foam);
X_car_sponge = (X_car_sponge - mean(X_car_sponge)) ./ std(X_car_sponge);


% Calculate Means
mean_black_foam = mean(X_black_foam);
mean_car_sponge = mean(X_car_sponge);
overall_mean = mean([X_black_foam; X_car_sponge]);

% Initialize the within-class scatter matrix
S_W = zeros(3, 3);

% Add scatter for each class
for i = 1:size(X_black_foam, 1)
    S_W = S_W + (X_black_foam(i,:) - mean_black_foam)' * (X_black_foam(i,:) - mean_black_foam);
end
for i = 1:size(X_car_sponge, 1)
    S_W = S_W + (X_car_sponge(i,:) - mean_car_sponge)' * (X_car_sponge(i,:) - mean_car_sponge);
end

mean_diff = mean_black_foam - mean_car_sponge;
S_B = mean_diff' * mean_diff;

% Solve the generalized eigenvalue problem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Extract the diagonal of eigenvalues matrix
eigenvalues = diag(eigenvalues);

% Sort the eigenvalues and corresponding eigenvectors in descending order
[~, sorted_indices] = sort(eigenvalues, 'descend');
eigenvectors = eigenvectors(:, sorted_indices);
disp(eigenvalues)

% Select the top eigenvectors
W = eigenvectors(:, 1);

% Project the data
Y_black_foam = X_black_foam * W;
Y_car_sponge = X_car_sponge * W;
% 3D Scatter Plot
figure;
scatter3(X_black_foam(:, 1), X_black_foam(:, 2), X_black_foam(:, 3), 'b', 'filled');
hold on;
scatter3(X_car_sponge(:, 1), X_car_sponge(:, 2), X_car_sponge(:, 3), 'r', 'filled');
% Add hyperplane (for simplicity, using the first LD)
% Define a grid for the hyperplane
[xGrid, yGrid] = meshgrid(linspace(min(X_black_foam(:,1)), max(X_black_foam(:,1)), 10), ...
                          linspace(min(X_black_foam(:,2)), max(X_black_foam(:,2)), 10));
% Calculate z values on the grid
zGrid = -(W(1)/W(3) * xGrid + W(2)/W(3) * yGrid);
surf(xGrid, yGrid, zGrid, 'FaceColor', 'green', 'FaceAlpha', 0.5);
title('3D Scatter Plot with LDA Hyperplane');
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
legend('Black Foam', 'Car Sponge', 'LDA Hyperplane');
grid on;
hold off;

% Select the top two eigenvectors for 2D projection
W_2D = eigenvectors(:, 1:2);

% Project the data onto the 2D subspace
Y_black_foam_2D = X_black_foam * W_2D;
Y_car_sponge_2D = X_car_sponge * W_2D;

% Visualization for 2D projection
figure;
scatter(Y_black_foam_2D(:, 1), Y_black_foam_2D(:, 2), 'b', 'filled');
hold on;
scatter(Y_car_sponge_2D(:, 1), Y_car_sponge_2D(:, 2), 'r', 'filled');
legend('Black Foam', 'Car Sponge');
title('LDA Projected Data (2D)');
xlabel('LDA1');
ylabel('LDA2');
grid on;
hold off;


figure;
scatter(Y_black_foam, zeros(size(Y_black_foam)), 'b', 'filled');
hold on;
scatter(Y_car_sponge, zeros(size(Y_car_sponge)), 'r', 'filled');
legend('Black Foam', 'Car Sponge');
title('LDA Projected Data');
xlabel('LDA Component');
hold off;