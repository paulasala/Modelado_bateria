function [Qcell] = flowRequiredCellConstPower(SoC, I, cv, flowFactor)
% FLOW REQUIRED PER CELL FOR A CONSTANT POWER
    % Obtains the flow need it for charge or discharge function

    % FF - flow factor
    % F - Constant of Faraday
    % Cv - Concentration of Vanadium % mol V/ L
    % SoC - State of charge
    % current - I(t) current variable 

F = 96485.3329; % C/mol e- 
    
    %   Discharge
    Qcell = (flowFactor * abs(I)) ./ (F * cv * (SoC)) * 60;  % (l/min)
    %   Charge
    % Qcell = (flowFactor * abs(I)) ./ (F * cv * (1-SoC)) * 60;  % (l/min)

end