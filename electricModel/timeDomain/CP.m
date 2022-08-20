function [battery, energy, t] = CP(battery,power, expectedSoC)
%CP Constant power simulation until an expectedSoC level

    %   deltaT - variation of time (salto de tiempo) in seconds
    %   z_k - SoC in a specific moment
    %   v_k - voltage in a specific moment 
    %   power (W)

%   Initialization
deltaT = 1; % seconds
t = 0;
energy = 0;
if battery.z_k > expectedSoC %current > expectedSoC
    power = -power; 
    while(battery.z_k > expectedSoC)
        i = power/battery.v_k;
        battery = simStep(i, battery, deltaT);
        t = t+1;
        energy = energy + power * t/3600;
        battery.eHistoric = [battery.eHistoric; energy];
    end
else
    while(battery.z_k < expectedSoC)
        i = power/battery.v_k;
        battery = simStep(i, battery, deltaT);
        t = t+1;
        energy = energy + power * t/3600;
        battery.eHistoric = [battery.eHistoric; energy];
    end
end



end

