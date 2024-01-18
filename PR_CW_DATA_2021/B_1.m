%question_a
% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');
colors = lines(6);
% Extract the individual variables
pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Standardize the data
pressure_standardized = (pressure - mean(pressure)) ./ std(pressure);
temperature_standardized = (temperature - mean(temperature)) ./ std(temperature);
vibration_standardized = (vibration - mean(vibration)) ./ std(vibration);

pressure_vector = pressure_standardized(:);
temperature_vector = temperature_standardized(:);
vibration_vector = vibration_standardized(:);
% Combine the variables into a single matrix for covariance calculation
% Each column of this matrix represents a variable
combinedData = [pressure_vector, temperature_vector, vibration_vector];


% Calculate the covariance matrix
covarianceMatrix = cov(combinedData);

% Display the covariance matrix
disp(covarianceMatrix);

% Calculate eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(covarianceMatrix);

% eigenvalues are on the diagonal of the eigenvalues matrix
% eigenvalues = diag(eigenvalues);

% Display the results
disp('Eigenvalues:');
disp(eigenvalues);
disp('Eigenvectors:');
disp(eigenvectors);



% question_b
% Origin of the eigenvectors
origin = [0, 0, 0];

% Plotting the eigenvectors
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,1), eigenvectors(2,1), eigenvectors(3,1), 'r');
hold on;
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,2), eigenvectors(2,2), eigenvectors(3,2), 'g');
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,3), eigenvectors(2,3), eigenvectors(3,3), 'b');
for i = 1:size(pressure_standardized, 1)
    scatter3(pressure_standardized(i,:), vibration_standardized(i,:), temperature_standardized(i,:), 36, colors(i,:), 'filled');
end
hold off;

% Setting the plot limits
axis equal;
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
title('3D Scatter Plot of PVT Data');
grid on;
legend();

% Adding a legend
legend('Eigenvector 1', 'Eigenvector 2', 'Eigenvector 3', 'acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');


%question_c
eigenvalues = diag(eigenvalues);
% Sort the eigenvalues in descending order and get indices
[sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');

% Extract the two largest eigenvalues
largest_eigenvalues = sorted_eigenvalues(1:2);

% Extract the eigenvectors corresponding to the two largest eigenvalues
F = eigenvectors(:, sort_index(1:2));

% Display the results
disp('Two Largest Eigenvalues:');
disp(largest_eigenvalues);
disp('Projection Matrix:');
disp(F);

%plot two large eigenvector
meanData = mean(combinedData, 1);
figure
quiver(meanData(1), meanData(2), F(1,1), F(2,1), 'r', 'LineWidth', 2);
hold on;
quiver(meanData(1), meanData(2), F(1,2), F(2,2), 'g', 'LineWidth', 2);

xlabel('Feature 1');
ylabel('Feature 2');
title('Eigenvectors of the Two Largest Eigenvalues');
hold off;
axis equal; % Set the aspect ratio such that the arrows are properly scaled
grid on;


%project tandardized data onto the two largest principal components 
projectedData = combinedData * F;

%plot 2D
figure;
hold on;

%set object labels
numDataPointsPerObject = size(projectedData, 1) / 6;
objectLabels = repmat(1:6, numDataPointsPerObject, 1);
objectLabels = objectLabels(:);

for obj = 1:6
    % Logical indexing to select rows
    objIndices = objectLabels == obj;
    
    % Plot with corresponding color
    scatter(projectedData(objIndices,1), projectedData(objIndices,2), 36, colors(obj,:), 'filled');
end

hold off;

xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('2D PCA Projection of PVT Data');
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');


%question d
figure;

% Number of principal components
numPCs = size(projectedData, 2);

% Loop through each principal component to create a subplot for each
for i = 1:numPCs
    % Create a subplot for each principal component
    subplot(numPCs, 1, i); 
    scatter(projectedData(:,i), zeros(size(projectedData,1), 1), 'filled');
    % Label y-axis as the current principal component
    ylabel(['PC' num2str(i)]);
end

xlabel('Component Score'); 
%title for all
sgtitle('Distribution Across Principal Components');