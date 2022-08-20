function [Qcell] = flowRequiredCell(We,Le,SoC, currentDensity, Cv, flowFactor)
% FLOW REQUIRED PER CELL FOR A CONSTANT CURRENT
% Obtains the flow need it for charge or discharge function

    % FF - flow factor
    % currentDensity, J - Current density (A/cm^2)
    % Aeff - Effective area
    % F - Constant of Faraday
    % Cv - Concentration of Vanadium % mol V/ L
    % SoC - State of charge

F = 96485.3329; % C/mol e-
Aeff = We * Le %m^2

%   Discharge
Qcell = (flowFactor * currentDensity * Aeff * 10000) ./ (F * Cv * (SoC)) * 60;  % (l/min)

%   Charge
% Qcell = (flowFactor * currentDensity * Aeff * 10000) ./ (F * Cv * (1-SoC)) * 60;  % (l/min)
end