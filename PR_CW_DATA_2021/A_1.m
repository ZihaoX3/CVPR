load('acrylic_211_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on acrylic
hold on;
load('black_foam_110_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on black_foam
load('car_sponge_101_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on car_sponge
load('flour_sack_410_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on flour_sack
load('kitchen_sponge_114_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on kitchen_sponge
load('steel_vase_702_03_HOLD.mat')
plot(F0Electrodes(1,1:300),'LineWidth',1); %plot Impedance on steel_vase
hold off;
xlabel('Time')
ylabel('Impedance Measurement')
title('Impedance Measurement')
legend('acrylic','black foam','car sponge','flour sack','kitchen sponge','steel vase');
