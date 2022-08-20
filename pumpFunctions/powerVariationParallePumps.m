function a = powerVariationParallePumps(data, flowRequired, rdtoMotor, rdtoVariador, liquidData, ecuInstalation,powerBattery)
% Inicialización de valores de rendimiento
    %   data - struct of pump
    %   rdtoMotor - Efficiency of the electric motor
    %   rdtoVariador - Efficiency of the variable frequency drive 
    %   liquidData - struct that contain rho, mu and gravity of the liquid used
    %   (electrolite)
    %   ecuInstalation - installation equation coefficients

format long
%   Selection of valids combinations of pumps
idx = [data.validLimit] > 0;
position = find(idx);
%----Data for power
%     power.name = [];
%     power.OP = []; %soc
%     power.Nref = []; %power
%     power.Nprima = []; %energy
%     power.ratioN = [];
%     power.powerPump = [];
%     power.powerPrimo = []; %soc
%     power.Nref = []; %power
%     power.Nprima = []; %energy
%     power.ratioN = [];


    for i = 1: length (position)
        j = position(:, i);    
        power(i).name = data(j).name;        
        % power(i).rdto = data(j).efficiency; % Q(L/min)
        power(i).OP = data(j).OP; % conjunto de bombas
        power(i).Nref = data(j).Nref; % (rpm)  velocidad nominal a la que trabaja la bomba
        power(i).numPumps = data(j).numPumps;
%   Equal parallel pumps working at the same speed
%   Qsistema_global = numPumps * Q_individual
        flowMaxSinglePump = power(i).OP(1) / data(j).numPumps; % Q(l/min); H(kPa) Intersección curva de la instalación con bomba
        flowPerPump = flowRequired ./ data(j).numPumps;
%   Head instalation values
        headInsatalation = ecuInstalation(1).*flowRequired.^2 + ecuInstalation(2) .* flowRequired + ecuInstalation(3); % (head - kPa)

    %   Power calculation of valid pumps
            %   Rpm per each new flowRequired N' = Q'/(Qref_tot/numPumps)*Nref
                Nprima = flowPerPump * power(i).Nref / flowMaxSinglePump; % (rpm)

             % Hz (herzios motor eléctrico)
                NprimaHz = Nprima ./60;

            %   Ratio = N'/Nref
                nRate = Nprima/power(i).Nref; % adimensional
            %   New efficiency of the pump per each new OP' 
            %       FLOW PER PUMP
                rdtoPrima = data(j).ecuRdto(1) .* nRate .^(-2) .* flowPerPump .^2 + data(j).ecuRdto(2) .* nRate.^(-1) .* flowPerPump + data(j).ecuRdto(3);
            %   Theoretical power required for the impeller P = gravity*rho*H*Q
            powerUtil = liquidData.g * liquidData.rho .* (headInsatalation.*1000 ./ liquidData.g ./liquidData.rho ) .* (flowPerPump ./ 60 ./ 1000); % kg*m^2/s^3 = W 

           %   Power required for the entire pumping system:
            powerRealPump = powerUtil ./ (rdtoPrima./100 ); % W Power required taking into account the rdto of the magnetic drive and the pump
            powerRealMotor = powerUtil ./ (rdtoMotor); % W
            powerRealVariador = powerUtil./ (rdtoVariador); % W    

            %   Power need it: P * numPumps / (rdtoPump * rdtoMotor * rdtoVariador)  
            powerReal =  powerUtil ./ (rdtoPrima./100 .* rdtoMotor .* rdtoVariador);
                powerONEcircuit=  data(j).numPumps * powerUtil ./ (rdtoPrima./100 .* rdtoMotor .* rdtoVariador); % W
                powerHydraulicSystem= powerONEcircuit.*2;
        %   Efficiency
            efficiency = powerHydraulicSystem ./ abs(powerBattery)*100;
            energyEfficiency = (abs(powerBattery)-powerHydraulicSystem)./(abs(powerBattery)+powerHydraulicSystem);


      power(i).nRate = nRate; 
      power(i).nPrima = Nprima;
      power(i).nPrimaHz = NprimaHz;
      power(i).nRdto = rdtoPrima;
      power(i).pImpeller = powerUtil;
      
      power(i).pPump = powerRealPump;  
      power(i).pMotor= powerRealMotor;
      power(i).pVariador= powerRealVariador;

      power(i).powerReal = powerReal;
      power(i).pONEcircuit = powerONEcircuit;
      power(i).pHydraulicSystem = powerHydraulicSystem;
      power(i).efficiency = efficiency;
      power(i).energyEfficiency = energyEfficiency;
     
    end
    a = power;
end