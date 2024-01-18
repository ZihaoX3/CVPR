load('F0_PVT.mat');
scatter3(Pressure(:,1), Vibration(:,1), Temperature(:,1), 36, 'filled');
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
title('3D Scatter Plot of PVT Data');
grid on;  % Add a grid for easier visualization
colors = lines(6); % Create a colormap with 6 colors


hold on;

%paint color
for i = 1:size(Pressure, 1) 
    scatter3(Pressure(i,1), Vibration(i,1), Temperature(i,1), 36, colors(i,:), 'filled');
end
hold off;

legend('acrylic', 'black foam', 'car sponge', 'flour sack', 'kitchen sponge', 'steel vase');
