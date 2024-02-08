% load PCA processed Electrode data
Electrode_PCA = load('Lab1/Electrode_PCA.mat');
Electrode_PCA = Electrode_PCA.projectedData;

for i = 1:size(Electrode_PCA,1)
    full_data(i).x = Electrode_PCA(i,:);
    full_data(i).y = floor((i-1)/10) + 1;
end

train_num = size(Electrode_PCA,1) * 0.6;
rand_indices = randperm(size(Electrode_PCA,1));
train_indices = rand_indices(1:train_num);
test_indices = rand_indices(train_num+1:end);

train_data = full_data(train_indices);
test_data = full_data(test_indices);

train_x = zeros(36,3);
train_y = zeros(36,1);
for i = 1:size(train_data,2)
    train_x(i,:) = train_data(i).x;
    train_y(i) = train_data(i).y;
end

test_x = zeros(24,3);
test_y = zeros(24,1);
for i = 1:size(test_data,2)
    test_x(i,:) = test_data(i).x;
    test_y(i) = test_data(i).y;
end


% Number of trees
nTrees = 800;

% Train the bagged ensemble of decision trees
model = TreeBagger(nTrees, train_x, train_y, 'Method', 'classification', 'OOBPrediction', 'On');

% OOBPrediction is set to 'On' to track out-of-bag prediction error.

view(model.Trees{1}, 'Mode', 'Graph');
view(model.Trees{2}, 'Mode', 'Graph');

% Predict the class labels for the test data
[predictedLabels, scores] = predict(model, test_x);

% Convert predicted labels from cell array to numeric array if necessary
predictedLabels = str2double(predictedLabels);

% Calculate the confusion matrix
[C,order] = confusionmat(test_y, predictedLabels);

% Display the confusion matrix
figure;
confusionchart(C, order);
title('Confusion Matrix');
xlabel('True Label');
ylabel('Predicted Label');

