% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');

% Extract the features for black foam and car sponge
pressure_black_foam = data.Pressure(2,:)';
vibration_black_foam = data.Vibration(2,:)';
temperature_black_foam = data.Temperature(2,:)';

pressure_car_sponge = data.Pressure(3,:)';
vibration_car_sponge = data.Vibration(3,:)';
temperature_car_sponge = data.Temperature(3,:)';

% Combine the features into pairs for each class
X_pv = [pressure_black_foam, vibration_black_foam; pressure_car_sponge, vibration_car_sponge];
X_pt = [pressure_black_foam, temperature_black_foam; pressure_car_sponge, temperature_car_sponge];
X_vt = [vibration_black_foam, temperature_black_foam; vibration_car_sponge, temperature_car_sponge];

% Create label vectors for the classes
labels = [ones(size(pressure_black_foam)); 2 * ones(size(pressure_car_sponge))];

% Define the pairs of features
feature_pairs = {X_pv, X_pt, X_vt};
feature_names = {'Pressure', 'Vibration', 'Temperature'};
pair_names = {'Pressure vs Vibration', 'Pressure vs Temperature', 'Vibration vs Temperature'};

% Perform LDA for each feature pair and plot
for i = 1:length(feature_pairs)
    % Extract the data for the current feature pair
    X = feature_pairs{i};
    
    % Standardize the data
    X_std = (X - mean(X)) ./ std(X);

    % Compute the means for each class
    mean_black_foam = mean(X_std(labels == 1,:));
    mean_car_sponge = mean(X_std(labels == 2,:));

    % Compute the scatter matrices
    S_W = cov(X_std(labels == 1,:)) + cov(X_std(labels == 2,:));
    mean_diff = mean_black_foam - mean_car_sponge;
    S_B = (mean_diff' * mean_diff) * length(mean_black_foam);
    
    % Solve the generalized eigenvalue problem
    [V, D] = eig(S_B, S_W);
    [~, ind] = sort(diag(D), 'descend');
    W = V(:,ind(1));  % Select the eigenvector with the largest eigenvalue
    
    % Project the data onto the LDA direction
    Y = X_std * W;
    
    % Determine the decision boundary
    db_point = mean([mean_black_foam; mean_car_sponge]);
    db_normal = W;
    db_line = @(x1, x2) db_point(1) + (x2 - db_point(2)) * db_normal(1) / db_normal(2);

    % Create the scatter plot for the current feature pair
    figure;
    scatter(X_std(labels == 1, 1), X_std(labels == 1, 2), 'b', 'filled');
    hold on;
    scatter(X_std(labels == 2, 1), X_std(labels == 2, 2), 'r', 'filled');
    
    % Plot the decision boundary
    x_lim = get(gca, 'xlim');
    y_lim = get(gca, 'ylim');
    line_x = linspace(x_lim(1), x_lim(2), 100);
    line_y = db_line(line_x, db_point(2));
    plot(line_x, line_y, 'k--', 'LineWidth', 2);
    
    % Formatting the plot
    xlabel(feature_names{mod(i,3)+1});
    ylabel(feature_names{mod(i+1,3)+1});
    title(['LDA Decision Boundary for ', pair_names{i}]);
    legend('Black Foam', 'Car Sponge', 'Decision Boundary');
    hold off;
end


