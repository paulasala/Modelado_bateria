function [hGravityLosses] = hGravity(rho, g, heightVariation,flowStack)
% GRAVITY HEAD LOSSES
    % rho - fluid density (kg/m^3)
    % g - gravity (m/s)
    % heightVariation - distance in height between two points (m)

flowStack = flowStack./flowStack; %    Inicilización para dar formato de vector con tamaño
hGravityLosses = [];
hGravityLosses = rho * g * heightVariation .* flowStack; % Pa
end