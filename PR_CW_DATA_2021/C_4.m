%3D and 1D projection

% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');

pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Initialize matrices with three columns for Pressure, Vibration, and Temperature
X_black_foam = zeros(size(pressure, 2), 3);
X_acrylic = zeros(size(pressure, 2), 3);

% Extract data for black foam and acrylic sponge
for i = 1 : size(pressure, 2)
    X_acrylic(i, 1) = pressure(6, i); % Pressure
    X_acrylic(i, 2) = vibration(6, i); % Vibration
    X_acrylic(i, 3) = temperature(6, i); % Temperature
    
    X_black_foam(i, 1) = pressure(4, i); % Pressure
    X_black_foam(i, 2) = vibration(4, i); % Vibration
    X_black_foam(i, 3) = temperature(4, i); % Temperature

end


% Standardization
X_black_foam = (X_black_foam - mean(X_black_foam)) ./ std(X_black_foam);
X_acrylic = (X_acrylic - mean(X_acrylic)) ./ std(X_acrylic);


% Calculate Means
mean_black_foam = mean(X_black_foam);
mean_acrylic = mean(X_acrylic);
overall_mean = mean([X_black_foam; X_acrylic]);

% Initialize the within-class scatter matrix
S_W = zeros(3, 3);

% Add scatter for each class
for i = 1:size(X_black_foam, 1)
    S_W = S_W + (X_black_foam(i,:) - mean_black_foam)' * (X_black_foam(i,:) - mean_black_foam);
end
for i = 1:size(X_acrylic, 1)
    S_W = S_W + (X_acrylic(i,:) - mean_acrylic)' * (X_acrylic(i,:) - mean_acrylic);
end

% Between-class scatter matrix
S_B = (mean_black_foam - overall_mean)' * (mean_black_foam - overall_mean) + ...
      (mean_acrylic - overall_mean)' * (mean_acrylic - overall_mean);

% Solve the generalized eigenvalue problem
[eigenvectors, eigenvalues] = eig(inv(S_W) * S_B);

% Extract the diagonal of eigenvalues matrix
eigenvalues = diag(eigenvalues);

% Sort the eigenvalues and corresponding eigenvectors in descending order
[~, sorted_indices] = sort(eigenvalues, 'descend');
eigenvectors = eigenvectors(:, sorted_indices);
disp(eigenvalues)

% Select the top eigenvectors (in this case, you'll typically pick one)
W = eigenvectors(:, 1);

% Project the data
Y_black_foam = X_black_foam * W;
Y_acrylic = X_acrylic * W;
% 3D Scatter Plot
figure;
scatter3(X_black_foam(:, 1), X_black_foam(:, 2), X_black_foam(:, 3), 'b', 'filled');
hold on;
scatter3(X_acrylic(:, 1), X_acrylic(:, 2), X_acrylic(:, 3), 'r', 'filled');
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
legend('Black Foam', 'Acrylic', 'LDA Hyperplane');
grid on;
hold off;

figure;
scatter(Y_black_foam, zeros(size(Y_black_foam)), 'b', 'filled');
hold on;
scatter(Y_acrylic, zeros(size(Y_acrylic)), 'r', 'filled');
legend('Black Foam', 'Acrylic');
title('LDA Projected Data');
xlabel('LDA Component');
hold off;
