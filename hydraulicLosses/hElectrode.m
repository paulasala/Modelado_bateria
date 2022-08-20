function [hElect] = hElectrode(Qe, mu,We,Le,He,df,epsilon,cteCK)
% Pressure drop in the electrode
% ke = (df^2)/cteCK * epsilon^3/((1-epsilon)^2)
    % df - Fiber diameter (m)
    % ke - un-plane permeability of porous electrode
    % Qe - volume flow rate throgh the electrode (l/min)
    % Le, We, He - electrode dimensions (m)
    % Epsilon - electrode porosity
    % cteCK - Kozeny-Carman constant
    % mu - electrolyte dynamic viscosity (kg/m*s)
    
    ke = (df ^ 2) / cteCK * (epsilon^3) / ((1 - epsilon)^ 2); % m^2

% Electrode Losses  
    hElect = (mu / ke) * (Le / (We * He)) * (Qe / (60 * 1000)); % Pa

end