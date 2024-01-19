% Load the data from the .mat file
data = load('Lab1/F0_Electrodes.mat');
colors = lines(6);

data = data.Electrodes;

% Standardize data
standardizedData = (data - mean(data)) ./ std(data);

% Find Covariance matrix
covarianceMatrix = cov(standardizedData);

% Find Eigenvectors and Eigenvalues
[eigenvectors, eigenvalues] = eig(covarianceMatrix);
disp(eigenvectors)
disp(eigenvalues)

eigenvalues = diag(eigenvalues);
% Sort the eigenvalues in descending order and get indices
format short;
[sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');
disp(sorted_eigenvalues);

pc_numbers = 1:length(eigenvalues);
plot(pc_numbers, sorted_eigenvalues, 'o-k', 'MarkerFaceColor', 'k');
xlabel('Component Numbers');
ylabel('Eigenvalue(Variance)');
title('Scree Plot');

 

% Extract the three largest eigenvalues
largest_eigenvalues = sorted_eigenvalues(1:3);
 
% Extract the eigenvectors corresponding to the three largest eigenvalues
F = eigenvectors(:, sort_index(1:3));
 
% Display the results
disp('Three Largest Eigenvalues:');
disp(largest_eigenvalues);
disp('Projection Matrix:');
disp(F);



projectedData = standardizedData * F;
disp(projectedData);
figure;
% Origin of the eigenvectors
origin = [0, 0, 0];

% Plotting the eigenvectors
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,1), eigenvectors(2,1), eigenvectors(3,1), 'r');
hold on;
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,2), eigenvectors(2,2), eigenvectors(3,2), 'g');
quiver3(origin(1), origin(2), origin(3), eigenvectors(1,3), eigenvectors(2,3), eigenvectors(3,3), 'b');
for i = 1:size(projectedData, 1)
    scatter3(projectedData(i,1), projectedData(i,2), projectedData(i,3), 36, colors(i,:), 'filled');
end
hold off;
legend('Eigenvector 1', 'Eigenvector 2', 'Eigenvector 3', 'acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');