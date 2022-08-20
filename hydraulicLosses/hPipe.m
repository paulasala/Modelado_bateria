function [hPiping] = hPipe(diameterPipe, Lpipe, epsilonPipe, Q, rho, mu)
% HEAD LOSS DUE TO PIPE
%   The function calculates the head due to piping
    % Q - flow through the pipe (l/min *(1/(1000*60)) -> m^3/s)
    % diameterPipe - diameter of the pipe (m)
    % L - Pipe lenght (m)
    % epsilonPipe - Pipe Internal Roughness  
    % rho - liquid density (kg/m^3)
    % mu - dynamic viscosity (Pa*s)
    % Apipe - Circular area of the pipe (m)
    % Re - Reynolds 

    % K - indica si se trata de flujo laminar(0) o turbulento(contador)
    
    Apipe = pi * (diameterPipe / 2) ^2; % m^2
    Re = diameterPipe * Q ./ (1000 * 60 * Apipe) * rho / mu;
    velocity = Q / Apipe * (1 / 1000 / 60); % m^3/s

for contador = 1 : length(Re)
        if Re(contador) < 2000 % Laminar flow
            f(contador) = 64/Re(contador);
            K(contador) = 0; % marker of laminar flow
        elseif Re(contador) > 2000
        % White-Colebrook function -> válido para transición a turbulento y flujo turbulento
        % MODIFICADO DE LA ECUACIÓN DE COLEBROOK DE MATLAB
        % Copyright (c) 2019 Ildeberto de los Santos Ruiz
            Ck = @(f) 1 / sqrt(f) + 2 * log10 ((epsilonPipe /diameterPipe) / 3.7 + 2.51 / ( Re(contador) * sqrt(f))); 
            lim = [eps 1]; % initial interval
            f(contador) = fzero (Ck, lim); % Solve the Colebrook-White function
            K(contador) = 1; % marker of turbulent flow
        end
    % HEAD LOSS DUE TO PIPE
    h(contador) = f(contador) * Lpipe / diameterPipe * rho * velocity(contador)^2 / 2; %Pa
end     
% f     % array that contains the values of f (factor de pérdidas por cortante o fricción
K       % show marker flow
hPiping = h;
end


