function a = powerVariationSingleCurve(data, flowRequired, rdtoMotor, rdtoVariador, liquidData, ecuInstalation, powerBattery)
% Inicialización de valores de rendimiento
    %   data - struct of pump
    %   rdtoMotor - Efficiency of the electric motor
    %   rdtoVariador - Efficiency of the variable frequency drive 
    %   liquidData - struct that contain rho, mu and gravity of the liquid used
    %   (electrolite)
rdtoMotor = rdtoMotor.*flowRequired./flowRequired;
rdtoVariador =rdtoVariador.*flowRequired./flowRequired;
%format long
idx = [data.validLimit] > 0;
position = find(idx);
for i = 1: length (position)
        j = position(:, i);
    % Extract data from another struct 
        power(i).name = data(j).name;    
        power(i).eqOrigin = data(j).eq; % Q(L/min)
        power(i).Nref = data(j).Nref; %(rpm)  velocidad a la que trabaja la bomba
             %flowRequired
% Calculations
        headInsatalation = ecuInstalation(1).* flowRequired.^2 + ecuInstalation(2) .* flowRequired + ecuInstalation(3);
            %headInsatalation

% Tratamiento de datos sin puntos homologos

for x = 1:length(flowRequired)
     % Rate


    p = [power(i).eqOrigin(3) power(i).eqOrigin(2)*flowRequired(x) (power(i).eqOrigin(1)*flowRequired(x)^2-headInsatalation(x))];
    a = roots(p);
    if a(1)>0
        nRate(x)=a(1);
    else 
        nRate(x) = a(2);
    end
   %    RPM
    Nprima(x) = nRate(x).*power(i).Nref;
    % Hz (herzios motor eléctrico)
    NprimaHz(x)= Nprima(x)./60;

    %   New efficiency of the pump per each new OP' 
    rdtoPrima(x) = data(j).ecuRdto(1) * nRate(x)^(-2) * flowRequired(x)^2 + data(j).ecuRdto(2) * nRate(x)^(-1) * flowRequired(x) + data(j).ecuRdto(3);
           
    %   Theoretical power P = gravity*rho*H*Q 
        % Power required for the impeller:
    powerUtil(x) = liquidData.g * liquidData.rho .* (headInsatalation(x).*1000 ./ liquidData.g ./liquidData.rho ) .* (flowRequired(x) ./ 60 ./ 1000); % kg*m^2/s^3 = W     
    
    powerReal(x) = powerUtil(x) ./ (rdtoPrima(x)./100 .* rdtoMotor(x) .* rdtoVariador(x)); % W
    %   Power required for the entire pumping system:
    powerRealPump(x) = powerReal(x) .* (1-rdtoPrima(x)./100 ).*rdtoMotor(x).*rdtoVariador(x); % W
    powerRealMotor(x) = powerReal(x) .* (1-rdtoMotor(x)).*rdtoVariador(x); % W
    powerRealVariador(x) = powerReal(x) .* (1-rdtoVariador(x)); % W 



    powerHydraulicSystem(x) = powerReal(x).*2;
     
    %   Efficiency
    efficiency(x) = powerHydraulicSystem(x) ./ abs(powerBattery(x))*100;
    energyEfficiency (x) = (abs(powerBattery(x))-powerHydraulicSystem(x))./(abs(powerBattery(x))+powerHydraulicSystem(x));

end
%plot(a) % plot de las revoluciones

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
      power(i).pHydraulicSystem = powerHydraulicSystem;
      power(i).efficiency = efficiency;
      power(i).energyEfficiency = energyEfficiency;
    end
 a = power;
end