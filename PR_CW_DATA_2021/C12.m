data = load('Lab1/F0_PVT.mat');

pressure_black_foam = data.Pressure(2,:)';
vibration_black_foam = data.Vibration(2,:)';
temperature_black_foam = data.Temperature(2,:)';

pressure_car_sponge = data.Pressure(3,:)';
vibration_car_sponge = data.Vibration(3,:)';
temperature_car_sponge = data.Temperature(3,:)';

X_pv = [pressure_black_foam vibration_black_foam; pressure_car_sponge vibration_car_sponge];
X_pt = [pressure_black_foam temperature_black_foam; pressure_car_sponge temperature_car_sponge];
X_vt = [vibration_black_foam temperature_black_foam; vibration_car_sponge temperature_car_sponge];

% Create label vectors for the classes
labels_pv = [ones(size(pressure_black_foam)); 2 * ones(size(pressure_car_sponge))];
labels_pt = labels_pv;  % Same labels for all, since the class division is the same
labels_vt = labels_pv;

% Perform LDA and plot for each feature pair
feature_pairs = {X_pv, X_pt, X_vt};
pair_names = {'Pressure vs Vibration', 'Pressure vs Temperature', 'Vibration vs Temperature'};
labels = {labels_pv, labels_pt, labels_vt};

for i = 1:length(feature_pairs)
    % Standardize the data for the current pair
    X_std = (feature_pairs{i} - mean(feature_pairs{i})) ./ std(feature_pairs{i});
    
    % Calculate the means for each class for the current feature pair
    mean_class1 = mean(X_std(labels{i} == 1,:));
    mean_class2 = mean(X_std(labels{i} == 2,:));
    
    % Compute the within-class scatter matrix
    S_W = cov(X_std(labels{i} == 1,:)) + cov(X_std(labels{i} == 2,:));
    
    % Compute the between-class scatter matrix
    mean_diff = mean_class1 - mean_class2;
    S_B = (mean_diff' * mean_diff) * sum(labels{i} == 1); % Use the number of observations in class 1
    
    % Solve the generalized eigenvalue problem
    [V, D] = eig(S_B, S_W);
    [~, ind] = sort(diag(D), 'descend');
    W = V(:,ind(1)); % Select the eigenvector with the largest eigenvalue
    
    % Project the data onto the LDA component
    Y_class1 = X_std(labels{i} == 1,:) * W;
    Y_class2 = X_std(labels{i} == 2,:) * W;
    
    % Plot the LDA projection for the current feature pair
    figure;
    scatter(Y_class1, zeros(size(Y_class1, 1), 1), 'b', 'filled');
    hold on;
    scatter(Y_class2, zeros(size(Y_class2, 1), 1), 'r', 'filled');
    title(['LDA Projection for ', pair_names{i}]);
    xlabel('LDA Component');
    ylabel(''); % No y-axis label needed as this is a 1D plot
    legend('Black Foam', 'Car Sponge');
    hold off;
end

%COMMENT ON RESULT, FOR TEMPERATURE AND VIRB the car and black are not easy
%to seperated
