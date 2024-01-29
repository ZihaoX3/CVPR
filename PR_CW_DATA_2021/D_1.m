%k-means clustering algorithm

% Load the data from the .mat file
data = load('Lab1/F0_PVT.mat');

pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Standardize the data
pressure_standardized = (pressure - mean(pressure)) ./ std(pressure);
temperature_standardized = (temperature - mean(temperature)) ./ std(temperature);
vibration_standardized = (vibration - mean(vibration)) ./ std(vibration);

pressure_reshape = reshape(pressure_standardized, [], 1);
vibration_reshape = reshape(vibration_standardized, [], 1);
temperature_reshape = reshape(temperature_standardized, [], 1);

% Store all PVT data into a 60*3 matrix
data = zeros(size(pressure,1)*size(pressure,2),3);
data(:,1) = pressure_reshape;
data(:,2) = vibration_reshape;
data(:,3) = temperature_reshape;

% Cluster number
k = 6;

% Iteration 
maxIter = 50;

% Initialise centroids
numPoints = size(data,1);
centroids = data(randperm(numPoints, k), :);
assignment = zeros(size(data,1),3);
disp(size(assignment));


for it = 1:maxIter
    % Assign each datapoint to nearest centroid
    for i = 1:numPoints
        assign_j = -1;
        min_distance = inf;
        for j = 1:k
            distance = sqrt(sum((data(i,:) - centroids(j,:)) .^ 2));
            if distance < min_distance
                min_distance = distance;
                assign_j = j;
            end
        end
        assignment(i) = assign_j; % Store the index of the centroid
    end
    
    tmp = centroids;

    % Calculate means of datapoints in each cluster
    for j = 1:k
        points = data(assignment == j, :);
        if size(points, 1) > 0
            centroids(j, :) = mean(points);
        end
    end

    % Terminate if converge, otherwise update centroid and go again
    if centroids == tmp 
        break;
    end
end

disp('Cluster Assignments:');
disp(assignment);
disp('Centroids:')
disp(centroids)

figure;
hold on;
colors = lines(k); % Generate k distinct colors
for j = 1:k
    % Select data points assigned to each cluster
    cluster_points = data(assignment == j, :);
    scatter(cluster_points(:,1), cluster_points(:,2), 36, colors(j,:), 'filled');
end
xlabel('Standardized Pressure');
ylabel('Standardized Vibration');
title('Cluster Assignments with Euclidean distance');
legend(arrayfun(@(x) sprintf('Cluster %d', x), 1:k, 'UniformOutput', false));
hold off;

        
        
        
        
        
        
        
