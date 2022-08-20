function [battery] = initBatt(nStacks, nCell, z_ini)
%INITBATT Summary of this function goes here
%   Detailed explanation goes here

%----Electrical Params:
    battery.r0        = 0.022 * nStacks + 0.00025 * nCell*nStacks;
    battery.rn        = 0;
    battery.rc        = 0;
    battery.Q         = 15000; %10000; %Ah %TODO: Definir aquí la capacidad
    battery.cells     = nCell * nStacks;   
    battery.ocv       = table2array(struct2table(load ('ocv_data.mat', 'ocv')));
    battery.soc       = table2array(struct2table(load ('ocv_data.mat', 'soc')));
    battery.etaChg    = 0.95; %charge efficiency

    battery.power = 12000 ;%7000 %(W)
    
%----Initial Status:
    battery.z_k      = z_ini;
    battery.v_k      = interp1(battery.soc, battery.ocv, battery.z_k) * battery.cells;
    battery.irn_k    = zeros(1,length(battery.rn));

%----Data for graphics
    battery.vHistoric = [];
    battery.zHistoric = []; %soc
    battery.pHistoric = []; %power
    battery.eHistoric = []; %energy
    battery.iHistoric = [];

    
end





