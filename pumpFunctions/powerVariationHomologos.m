function a = powerVariationHomologos(data, flowRequired, rdtoMotor, rdtoVariador, liquidData, ecuInstalation,powerBattery)
% Inicialización de valores de rendimiento
    %   data - struct of pump
    %   rdtoMotor - Efficiency of the electric motor
    %   rdtoVariador - Efficiency of the variable frequency drive 
    %   liquidData - struct that contain rho, mu and gravity of the liquid used
    %   (electrolite)

%format long
idx = [data.validLimit] > 0;
b = flowRequired./flowRequired;

position = find(idx);
    for i = 1: length (position)
        j = position(:, i);
        power(i).name = data(j).name;

   % Extract data from another struct     
        %power(i).rdto = data(j).efficiency; % Q(L/min)
        power(i).maxOP = data(j).maxOperatingPoint; % Q(l/min); H(kPa) Intersección curva de la instalación con bomba
        power(i).Nref = data(j).Nref; %(rpm)  velocidad a la que trabaja la bomba
        power(i).efficiency = data(j).efficiency;
            %flowRequired

% Calculations
        headInsatalation = ecuInstalation(1).* flowRequired.^2 + ecuInstalation(2) .* flowRequired + ecuInstalation(3);
            %headInsatalation
        % COMPROBADO Y TODO OK HASTA AQUI (CAUDAL Y ALTURA SE CORRESPONDEN CON LA GRÁFICA

% EL OP de la curva pasiva de la instalación con la bomba es correcto, la
% eficiencia corresponde con los datos de fabricante.


% %PUNTOS HOMÓLOGOS AQUÍ PUEDE SER PROBLEMÁTICO
%         for x = 1:length(flowRequired)
%             %   Rpm per each new flowRequired
%             Nprima(x) = flowRequired(x) * power(i).Nref ./ power(i).maxOP(1); % (rpm)
%             %   Ratio = N'/Nref
%             ratio(x) = Nprima(x)/power(i).Nref; % adimensional
%             %   New efficiency of the pump per each new OP' 
%             
% 
%             rdtoPrima = data(j).efficiency *b;
%             %   Theoretical power P = gravity*rho*H*Q
%             powerUtilOPmax= liquidData.g * liquidData.rho * (power(i).maxOP(2).*1000 / liquidData.g ./liquidData.rho ) * (power(i).maxOP(1) / 60 / 1000); % kg*m^2/s^3 = W
%             powerUtilPrima(x)=powerUtilOPmax.*ratio(x)^(3);
% %             % ES LA POTENCIA ÚTIL EN EL RODETE -> CORRECTA COMPROBADO CON EL OP y el rdto
% %             powerReal(x) = powerUtil(x) ./ (rdtoPrima(x)./100 .* rdtoMotor .* rdtoVariador); % W
% %             % Check teoricamente coincide
% %             %powerRealkW(x) = powerReal(x) .* 10e-3; % kW
% % 
% %             % Efficiency
% %             efficiency(x) = powerReal(x) ./ abs(powerBattery(x))*100;
%         end

%   Rpm per each new flowRequired
Nprima = flowRequired * power(i).Nref ./ power(i).maxOP(1); % (rpm)
%   Hz per each Nprima
NprimaHz = Nprima./60;
%   Ratio = N'/Nref
ratio = Nprima/power(i).Nref; % adimensional
%   Efficiency of the pump per each new OP' it's the same
rdtoPrima = data(j).efficiency *b;
%   Theoretical power P = gravity*rho*H*Q
powerUtilOPmax = liquidData.g * liquidData.rho * (power(i).maxOP(2).*1000 / liquidData.g ./liquidData.rho ) * (power(i).maxOP(1) / 60 / 1000); % kg*m^2/s^3 = W     
% W'=W_nom*n_ratio^3
powerUtilPrima = powerUtilOPmax*ratio.^(3);

% ES LA POTENCIA ÚTIL EN EL RODETE -> CORRECTA COMPROBADO CON EL OP y el rdto
powerReal = powerUtilPrima ./ (rdtoPrima/100 * rdtoMotor * rdtoVariador); % W

% Efficiency
efficiency = powerReal ./ abs(powerBattery)*100;

     power(i).nRate = ratio;
     power(i).nPrima = Nprima;
     power(i).nPrimaHz = NprimaHz;
     power(i).nRdto = rdtoPrima;
    % power(i).powerImpeller = powerUtilOPmax;
     power(i).powerImpeller=powerUtilPrima;
     power(i).powerReal = powerReal;
     power(i).efficiency = efficiency;
     %power(i).powerRealkW = powerRealkW;
      
    end
a = power;
end