data = load('acrylic_211_01_HOLD.mat');

elec = data.F0Electrodes;

Electrodes = zeros(2,2,19);

Electrodes(1,1,:) = elec(:,1);
disp(Electrodes(1,1,:));