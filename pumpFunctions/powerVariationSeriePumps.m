function bb = powerVariationSeriePumps(data, flowRequired, rdtoMotor, rdtoVariador, liquidData, ecuInstalation,powerBattery)
% POWER
    %   data - struct of pump
    %   rdtoMotor - Efficiency of the electric motor
    %   rdtoVariador - Efficiency of the variable frequency drive 
    %   liquidData - struct that contain rho, mu and gravity of the liquid used
    %   (electrolite)
    %   ecuInstalation - installation equation coefficients
rdtoMotor = rdtoMotor.*flowRequired./flowRequired;
rdtoVariador =rdtoVariador.*flowRequired./flowRequired;

format short
%   Selection of valids combinations of pumps
idx = [data.validLimit] > 0;
position = find(idx);
    for i = 1: length (position)
        j = position(:, i);
        power(i).name = data(j).name;
        power(i).numPumps = data(j).numPumps;
        power(i).rdto = data(j).efficiency; % Q(L/min)
        rdtoPrima=power(i).rdto*flowRequired./flowRequired;
        power(i).maxOP = data(j).maxOperatingPoint; % Q(l/min); H(kPa) Intersección curva de la instalación con bomba
        power(i).Nref = data(j).Nref; %(rpm)  velocidad a la que trabaja la bomba
        
%   Equal pumps in serie working at the same speed
%   Qsistema_global =  Q_individual
%   H_global_sistem =  numPumps* H_individual -> H_individual = H_global_sistem/ numPumps 
        headInstalation = (ecuInstalation(1).*flowRequired.^2 + ecuInstalation(2) .* flowRequired + ecuInstalation(3));
        headPerPump = headInstalation./data(j).numPumps;
  %   Power calculation of valid pumps        
        for x = 1:length(flowRequired)
            %   Rpm per each new flowRequired
            Nprima(x) = flowRequired(x) .* power(i).Nref ./ power(i).maxOP(1); % (rpm)
                %   Hz
            NprimaHz(x) = Nprima(x)./60; % Hz

            %   Ratio = N'/Nref
            nRate(x) = Nprima(x)/power(i).Nref; % adimensional
            %   New efficiency of the pump per each new OP' 
            %rdtoPrima(x) = data(j).ecuRdto(1) * nRate(x)^(-2) * flowRequired(x)^2 + data(j).ecuRdto(2) * nRate(x)^(-1) * flowRequired(x) + data(j).ecuRdto(3);
            
            %   Theoretical power P = gravity*rho*H*Q POWER IMPELLER
            powerUtil(x) = liquidData.g * liquidData.rho .* (headPerPump(x) .* 1000 ./ liquidData.g ./ liquidData.rho) * (flowRequired(x) ./ 60 ./ 1000); % kg*m^2/s^3 = W

                   % powerRealkW(x) = powerReal(x) .* 10e-3; % kW

             %   Power need it: P * numPumps / (rdtoPump * rdtoMotor * rdtoVariador)    
            powerReal(x) = powerUtil(x) ./ (rdtoPrima(x)./100 .* rdtoMotor(x) .* rdtoVariador(x)); % W
            
            %   Power required for the entire pumping system:
            powerRealPump(x) = powerReal(x) .* (1-rdtoPrima(x)./100 ).*rdtoMotor(x).*rdtoVariador(x); % W
            powerRealMotor(x) = powerReal(x) .* (1-rdtoMotor(x)).*rdtoVariador(x); % W
            powerRealVariador(x) = powerReal(x) .* (1-rdtoVariador(x)); % W 
    powerONEcircuit (x) = data(j).numPumps .* powerReal(x);
    powerHydraulicSystem(x) = data(j).numPumps .* powerReal(x).*2;
     
    %   Efficiency
    efficiency(x) = powerHydraulicSystem(x) ./ abs(powerBattery(x))*100;
energyEfficiency(x) = (abs(powerBattery(x))-powerHydraulicSystem(x))./(abs(powerBattery(x))+powerHydraulicSystem(x));
end


%plot(rdtoPrima)
      power(i).nRate = nRate; 
      power(i).nPrima = Nprima;
      power(i).nPrimaHz = NprimaHz;
      power(i).nRdto = rdtoPrima;
      power(i).pImpeller = powerUtil;
      power(i).powerReal = powerReal;
      power(i).pPump = powerRealPump;  
      power(i).pMotor= powerRealMotor;
      power(i).pVariador= powerRealVariador;
      power(i).pONEcircuit = powerONEcircuit;
      power(i).pHydraulicSystem = powerHydraulicSystem;
      power(i).efficiency = efficiency;
      power(i).energyEfficiency = energyEfficiency;      
    end
    bb = power;
end