% flour sack vs steel vase
data = load('Lab1/F0_PVT.mat');

pressure_flour_sack = data.Pressure(4,:)';
vibration_flour_sack = data.Vibration(4,:)';
temperature_flour_sack = data.Temperature(4,:)';

pressure_steel_vase = data.Pressure(6,:)';
vibration_steel_vase = data.Vibration(6,:)';
temperature_steel_vase = data.Temperature(6,:)';

X_pv = [pressure_flour_sack vibration_flour_sack; pressure_steel_vase vibration_steel_vase];
X_pt = [pressure_flour_sack temperature_flour_sack; pressure_steel_vase temperature_steel_vase];
X_vt = [vibration_flour_sack temperature_flour_sack; vibration_steel_vase temperature_steel_vase];

% Create label vectors for the classes
labels_pv = [ones(size(pressure_flour_sack)); 2 * ones(size(pressure_steel_vase))];
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
    S_B = (mean_class1 - mean_class2)' * (mean_class1 - mean_class2);


    % Solve the generalized eigenvalue problem
    S = inv(S_W) * S_B;
    [eigenvectors, eigenvalues] = eig(S);
    eigenvalues = diag(eigenvalues);
    [sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');
    W = eigenvectors(:, sort_index(1));
    
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
    legend('Flour sack', 'Steel Vase');
    hold off;
end