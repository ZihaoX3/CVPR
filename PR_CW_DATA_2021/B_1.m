% B_1: PCA for PVT

% question_a: Calculate cov matrix, eigenvalues and eigenvectors
% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');

colors = lines(6);
% Extract the individual variables
pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

combinedData = [pressure(1,:),pressure(2,:),pressure(3,:),pressure(4,:),pressure(5,:),pressure(6,:);
    vibration(1,:),vibration(2,:),vibration(3,:),vibration(4,:),vibration(5,:),vibration(6,:);
    temperature(1,:),temperature(2,:),temperature(3,:),temperature(4,:),temperature(5,:),temperature(6,:);];


% Standardize the data
combinedData = zscore(combinedData');

% Calculate the covariance matrix
covarianceMatrix = cov(combinedData);

% Display the covariance matrix
disp('Covariance Matrix:');
disp(covarianceMatrix);

% Calculate eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(covarianceMatrix);

% Display the results
disp('Eigenvalues:');
disp(eigenvalues);
disp('Eigenvectors:');
disp(eigenvectors);


% question_b: Stndardised data with PCs displayed
% Origin of the eigenvectors
origin = [0, 0, 0];

% Plotting the eigenvectors
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,1), eigenvectors(2,1), eigenvectors(3,1), 'r');
hold on;
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,2), eigenvectors(2,2), eigenvectors(3,2), 'g');
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,3), eigenvectors(2,3), eigenvectors(3,3), 'b');

for i = 1:6
    scatter3(combinedData((i-1)*10+(1:10),1), combinedData((i-1)*10+(1:10),2), combinedData((i-1)*10+(1:10),3), 36, colors(i,:), 'filled');
end
hold off;

% Setting the plot
axis equal;
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
title('3D Scatter Plot of PVT Data with PCs');
grid on;

% Adding a legend
legend('Eigenvector 1', 'Eigenvector 2', 'Eigenvector 3', 'acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');


% question_c:  Reduce data to 2-D
% Sort the eigenvalues in descending order and get indices
eigenvalues = diag(eigenvalues);
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

% Project the data on principal components
projectedData = combinedData * F;

figure;
hold on;
for i = 1:6
    scatter(projectedData((i-1)*10+(1:10),1),projectedData((i-1)*10+(1:10),2), 36, colors(i,:), "filled");
end

hold off;
title('2D PVT Data projected on PCs');
xlabel('PC1')
ylabel('PC2')
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');


% question d: How data is distributed across all PCs
F = eigenvectors(:, sort_index(1:3));
projectedData = combinedData * F;

figure;
hold on;
% Number of principal components
numPCs = size(projectedData, 2);

% Loop through each principal component to create a subplot for each
for i = 1:numPCs
    % Create a subplot for each principal component
    subplot(numPCs, 1, i); 
    scatter(projectedData(:,i), zeros(size(projectedData,1), 1), 'filled');
    title("Distributed PVT DATA across PC"+i)
    % Label y-axis as the current principal component
    ylabel(['PC' num2str(i)]);
    xlim([-4 4]);
end
hold off;