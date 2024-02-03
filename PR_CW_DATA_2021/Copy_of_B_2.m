% Load the data from the .mat file
data = load('Lab1/F0_Electrodes.mat');
colors = lines(6);

Electrodes = data.Electrodes;
electrodes = zeros(60,19);

count = 1;
for i = 1:size(Electrodes,1)
    for j = 1:size(Electrodes,2)
        electrodes(count,:) = Electrodes(i,j,:);
        count = count+1; 
    end
end


% Standardize data
standardizedData = (electrodes - mean(electrodes)) ./ std(electrodes);

% Find Covariance matrix
covarianceMatrix = cov(standardizedData);

% Find Eigenvectors and Eigenvalues
[eigenvectors, eigenvalues] = eig(covarianceMatrix);


% Sort the eigenvalues in descending order and get indices
eigenvalues = diag(eigenvalues);
format short;
[sorted_eigenvalues, sort_index] = sort(eigenvalues, 'descend');
disp(sorted_eigenvalues);

% Scree plot
pc_numbers = 1:length(eigenvalues);
plot(pc_numbers, sorted_eigenvalues, 'o-k', 'MarkerFaceColor', 'k');
xlabel('Component Numbers');
ylabel('Eigenvalue(Variance)');
title('Variances of each PC');


 
% Extract the three largest eigenvalues
largest_eigenvalues = sorted_eigenvalues(1:3);
 
% Extract the eigenvectors corresponding to the three largest eigenvalues
F = eigenvectors(:, sort_index(1:3));
 
% Display the results
disp('Three Largest Eigenvalues:');
disp(largest_eigenvalues);
disp('Projection Matrix:');
disp(F);


% Project data on PCs
projectedData = standardizedData * F;
disp('projected data');
disp(projectedData);

% 3D scatter plot of projected data
figure;
scatter3(projectedData(:,1), projectedData(:,2), projectedData(:,3), 'filled');
title('3D Scatter Plot of Electrode Data on First Three PCs');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
grid on;
