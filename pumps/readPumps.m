function [pumps] = readPumps()
Files = dir('pumps/*.xlsx'); % strcat: concatena cadenas horizontales

for i = 1:length(Files)
    pumpName = split(Files(i).name, '.'); % Coge el nombre y lo divide por el punto
    pumps(i).name = pumpName{1}; % recoge el nombre de la bomba

    data = readmatrix(strcat('pumps/', Files(i).name));
    
% Polinomio Flow-Head
    q = data (:,1).* 1000 ./60; % data: (Q: m^3/h) -> (Q: L/min)
    h = data (:,2).* 9.81 .* 1000 ./ 1000; % data: (H: mca) -> (H: kPa) 
    [pumps(i).eq,S] = polyfit(q,h,2);
    pumps(i).R2 = 1 - (S.normr/norm(h - mean(h)))^2;


% Polinomio Flow-Efficiency 
    qEfficiency = data (:,5).* 1000 ./60; % data: (Q: m^3/h) -> (Q: L/min)
    rdto  = data (:,6);
    pumps(i).ecuRdto = polyfit(qEfficiency, rdto, 2);
% Revoluciones por min
    rotationSpeed = data(2,8);
    pumps(i).Nref = rotationSpeed; %rpm
% % Power
%     qPower = data (:,3).* 1000 ./60; % data: (Q: m^3/h) -> (Q: L/min)
%     hPower = data (:,4); % data: (kW)  
%     pumps(i).ecuPower = polyfit(qPower, hPower, 2);
end

 

%opts = detectImportOptions(strcat('pumps/',Files(1).name))
