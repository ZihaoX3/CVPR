% A_1: View the time series sensor data for PVT and Electrodes

% Impedence
figure;
load('acrylic_211_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on acrylic of trail 3
hold on;
load('black_foam_110_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on black_foam of trail 3
load('car_sponge_101_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on car_sponge of trail 3
load('flour_sack_410_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on flour_sack of trail 3
load('kitchen_sponge_114_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on kitchen_sponge of trail 3
load('steel_vase_702_03_HOLD.mat')
plot(F0Electrodes(1,1:200),'LineWidth',1); %plot Impedance on steel_vase of trail 3
hold off;
xlabel('Time')
ylabel('Impedance Measurement')
title('Impedance Measurement')
legend('acrylic','black foam','car sponge','flour sack','kitchen sponge','steel vase');


% Vibration
figure;
load('acrylic_211_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on acrylic of trail 3
hold on;
load('black_foam_110_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on black_foam of trail 3
load('car_sponge_101_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on car_sponge of trail 3
load('flour_sack_410_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on flour_sack of trail 3
load('kitchen_sponge_114_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on kitchen_sponge of trail 3
load('steel_vase_702_03_HOLD.mat')
plot(F0pac(2,1:200),'LineWidth',1); %plot Vibration on steel_vase of trail 3
hold off;
xlabel('Time')
ylabel('Vibration Measurement')
title('Vibration Measurement')
legend('acrylic','black foam','car sponge','flour sack','kitchen sponge','steel vase');


% Pressure
figure;
load('acrylic_211_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on acrylic of trail 3
hold on;
load('black_foam_110_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on black_foam of trail 3
load('car_sponge_101_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on car_sponge of trail 3
load('flour_sack_410_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on flour_sack of trail 3
load('kitchen_sponge_114_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on kitchen_sponge of trail 3
load('steel_vase_702_03_HOLD.mat')
plot(F0pdc(1,1:200),'LineWidth',1); %plot Pressure on steel_vase of trail 3
hold off;
xlabel('Time')
ylabel('Pressure Measurement')
title('Pressure Measurement')
legend('acrylic','black foam','car sponge','flour sack','kitchen sponge','steel vase');



% Temperature 
figure;
load('acrylic_211_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on acrylic of trail 3
hold on;
load('black_foam_110_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on black_foam of trail 3
load('car_sponge_101_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on car_sponge of trail 3
load('flour_sack_410_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on flour_sack of trail 3
load('kitchen_sponge_114_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on kitchen_sponge of trail 3
load('steel_vase_702_03_HOLD.mat')
plot(F0tdc(1,1:200),'LineWidth',1); %plot Temperature on steel_vase of trail 3
hold off;
xlabel('Time')
ylabel('Temperature Measurement')
title('Temperature Measurement')
legend('acrylic','black foam','car sponge','flour sack','kitchen sponge','steel vase');