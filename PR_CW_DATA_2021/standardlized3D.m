% Load the data
data = load('Lab1/F0_PVT.mat');
% Create a colormap with as many colors as you have objects
colors = lines(6);

pressure = data.Pressure;
temperature = data.Temperature;
vibration = data.Vibration;

% Standardize the data
pressure_standardized = (pressure - mean(pressure)) ./ std(pressure);
temperature_standardized = (temperature - mean(temperature)) ./ std(temperature);
vibration_standardized = (vibration - mean(vibration)) ./ std(vibration);


% Create a new figure
figure;

hold on;
% Loop over each object and plot with a unique color
for i = 1:size(pressure_standardized, 1)
    scatter3(pressure_standardized(i,:), vibration_standardized(i,:), temperature_standardized(i,:), 36, colors(i,:), 'filled');
end

hold off;

% Label the axes
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
title('3D standardized Scatter Plot of PVT Data');
grid on;
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');

% Set the view for 3D plot
view(3);