clearvars; close all; clc;

%battery properties
battery = initBatt(4, 14, 0.7); % nStacks, nCell, z_ini

%Current profile simulation
current = [-10, 10, 10, 10, -10];
tic
for i = 1:length(current)
    battery = simStep(current(i),battery,1);
end
toc

%Power to desire SoC simulation
tic
[battery, t] = CP(battery, 7000, 0.20); %Constant Power simulation
toc

figure()
plot(battery.vHistoric, 'red', 'LineWidth', 1.5)
ylabel('Voltage [V]')
grid on
title('Battery terminal voltage')
xlabel('Time [s]')

figure()
plot(battery.iHistoric, 'blue', 'LineWidth', 1.5)
ylabel('Current [A]')
grid on
title('Battery current')
xlabel('Time [s]')

figure()
plot(battery.pHistoric, 'LineWidth', 1.5)
ylabel('Power [W]')
grid on
title('Battery power')
xlabel('Time [s]')

figure()
plot(battery.zHistoric*100, 'LineWidth', 1.5)
ylabel('SoC [%]')
grid on
title('Battery SoC')
xlabel('Time [s]')
