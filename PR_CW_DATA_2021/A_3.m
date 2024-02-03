% Load the data
load('Lab1/F0_PVT.mat');

% Create a colormap with as many colors as you have objects
% acrylic: dark blue
% black foam: red
% car sponge: yellow
% flour sack: purple
% kitchen sponge: green
% steel vase: light blue
colors = lines(6);

% Create a new figure
figure;

hold on;
% Loop over each object and plot with a unique color
for i = 1:size(Pressure, 1)
    scatter3(Pressure(i,:), Vibration(i,:), Temperature(i,:), 36, colors(i,:), 'filled');
end

hold off;

% Label the axes
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
title('3D Scatter Plot of PVT Data');
grid on;
legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');

% Set the view for 3D plot
view(3);