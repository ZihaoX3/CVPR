% B_2: PCA for Electrode

% Load the data from the .mat file
data = load('Lab1/F0_Electrodes.mat');
colors = lines(6);

% Fetch electrode data
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


% Define the directory and filename
targetDirectory = 'Lab1';


% Check if the directory exists, and if not, create it
if ~exist(targetDirectory, 'dir')
    mkdir(targetDirectory);
end

% Define the full path to the file
Electrode_PCA = fullfile(targetDirectory, 'Electrode_PCA.mat');
save(Electrode_PCA,'projectedData');

% Assuming projectedData is [60 x 3], with each set of 10 observations corresponding to a different object

% Create a new figure
figure;
hold on;

% Define colors
colors = lines(6);

% Loop over each set of 10 observations to plot them with a unique color
for i = 1:6
    % Calculate the index range for the current object
    idxRange = (1:10) + (i-1)*10;
    % Plot the data points for the current object
    scatter3(projectedData(idxRange,1), projectedData(idxRange,2), projectedData(idxRange,3), 36, colors(i,:), 'filled');
end

hold off;

% Label the axes
xlabel('Principal Component 1');
ylabel('Principal Component 2');
zlabel('Principal Component 3');
title('3D Visualization of Electrode Data on Principal Components');
grid on;
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');
view(3);
