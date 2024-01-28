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



mean_black_foam = mean(X_black_foam);
mean_car_sponge = mean(X_car_sponge);

% Initialize the within-class scatter matrix S_W
S_W = zeros(3, 3);

% Calculate S_W
for i = 1 : size(X_black_foam, 1)
    S_W = S_W + (X_black_foam(i,:) - mean_black_foam)' * (X_black_foam(i,:) - mean_black_foam);
end
for i = 1 : size(X_car_sponge, 1)
    S_W = S_W + (X_car_sponge(i,:) - mean_car_sponge)' * (X_car_sponge(i,:) - mean_car_sponge);
end
for i = 1 : size(pressure,2)
    S_W = S_W + (X_black_foam(i,:) - mean(X_black_foam))' * (X_black_foam(i,:) - mean(X_black_foam));
    S_W = S_W + (X_car_sponge(i,:) - mean(X_car_sponge))' * (X_car_sponge(i,:) - mean(X_car_sponge));
end

S_B = (mean(X_black_foam) - mean(X_car_sponge))' * (mean(X_black_foam) - mean(X_car_sponge));

S = inv(S_W) * S_B;

[eigenvectors, eigenvalues] = eig(S);
disp('Eigenvectors');
disp(eigenvectors);
disp('Eigenvalues');
disp(eigenvalues);

eigenvalues = diag(eigenvalues);
% Sort the eigenvalues in descending order and get indices
[sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');
feature_vector = eigenvectors(:, sort_index(1));
disp(feature_vector);


figure;
hold on;
for i = 1:size(X_black_foam, 1)
    plot(X_black_foam(i, 1), X_black_foam(i, 2), 'b.');
    plot(X_car_sponge(i, 1), X_car_sponge(i, 2), 'r.');
end
quiver(0,0,feature_vector(1),feature_vector(2));
hold off;

figure;
hold on;
for i = 1:size(X_black_foam, 1)
    plot(X_black_foam(i, 1), X_black_foam(i, 3), 'b.');
    plot(X_car_sponge(i, 1), X_car_sponge(i, 3), 'r.');
end
quiver(0,0,feature_vector(1),feature_vector(3));
hold off;

figure;
hold on;
for i = 1:size(X_black_foam, 1)
    plot(X_black_foam(i, 2), X_black_foam(i, 3), 'b.');
    plot(X_car_sponge(i, 2), X_car_sponge(i, 3), 'r.');
end
quiver(0,0,feature_vector(2),feature_vector(3));
hold off;

