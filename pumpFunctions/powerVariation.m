function a = powerVariation(data, flowRequired, rdtoMotor, rdtoVariador, liquidData, ecuInstalation,powerBattery)
% Inicialización de valores de rendimiento
    %   data - struct of pump
    %   rdtoMotor - Efficiency of the electric motor
    %   rdtoVariador - Efficiency of the variable frequency drive 
    %   liquidData - struct that contain rho, mu and gravity of the liquid used
    %   (electrolite)

%format long
idx = [data.validLimit] > 0;
position = find(idx);
    for i = 1: length (position)
        j = position(:, i);
        power(i).name = data(j).name;

   % Extract data from another struct     
        %power(i).rdto = data(j).efficiency; % Q(L/min)
        power(i).maxOP = data(j).maxOperatingPoint; % Q(l/min); H(kPa) Intersección curva de la instalación con bomba
        power(i).Nref = data(j).Nref; %(rpm)  velocidad a la que trabaja la bomba
            %flowRequired

% Calculations
        headInsatalation = ecuInstalation(1).* flowRequired.^2 + ecuInstalation(2) .* flowRequired + ecuInstalation(3);
            %headInsatalation
        % COMPROBADO Y TODO OK HASTA AQUI (CAUDAL Y ALTURA SE CORRESPONDEN CON LA GRÁFICA

% EL OP de la curva pasiva de la instalación con la bomba es correcto, la
% eficiencia corresponde con los datos de fabricante.


%PUNTOS HOMÓLOGOS AQUÍ PUEDE SER PROBLEMÁTICO
        for x = 1:length(flowRequired)
            %   Rpm per each new flowRequired
            Nprima(x) = flowRequired(x) * power(i).Nref ./ power(i).maxOP(1); % (rpm)
            %   Ratio = N'/Nref
            ratio(x) = Nprima(x)/power(i).Nref; % adimensional
            %   New efficiency of the pump per each new OP' 
            rdtoPrima(x) = data(j).ecuRdto(1) * ratio(x)^(-2) * flowRequired(x)^2 + data(j).ecuRdto(2) * ratio(x)^(-1) * flowRequired(x) + data(j).ecuRdto(3);
            %   Theoretical power P = gravity*rho*H*Q
            powerUtil(x) = liquidData.g * liquidData.rho .* (headInsatalation(x).*1000 ./ liquidData.g ./liquidData.rho ) .* (flowRequired(x) ./ 60 ./ 1000); % kg*m^2/s^3 = W
        
            % ES LA POTENCIA ÚTIL EN EL RODETE -> CORRECTA COMPROBADO CON EL OP y el rdto
            powerReal(x) = powerUtil(x) ./ (rdtoPrima(x)./100 .* rdtoMotor .* rdtoVariador); % W
            % Check teoricamente coincide
            %powerRealkW(x) = powerReal(x) .* 10e-3; % kW

            % Efficiency
            efficiency(x) = powerReal(x) ./ abs(powerBattery(x))*100;
        end

      
     power(i).nRate = ratio;
     power(i).nPrima = Nprima;
     power(i).nRdto = rdtoPrima;
     power(i).powerImpeller = powerUtil;
     power(i).powerReal = powerReal;
     power(i).efficiency = efficiency;
     %power(i).powerRealkW = powerRealkW;
      
    end
a = power;
end