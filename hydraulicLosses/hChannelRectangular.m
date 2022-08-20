function [head] = hChannelRectangular(W, H, L, flow, rho, mu, e)
% Head loss in rectangular channels
  % Manifold parameters
    %   W, H, L (m)
    %   flow - (l/min)
    %   rho - fluid density (kg/m^3)
    %   mu - dynamic viscosity of the fluid (Pa*s)
    %   e - Pipe roughtness, it's low since PVC material
    %   fd - Friction factor for Laminar, Transient and Turbulent Flow
    %   Dh - hidraulic diameter of rectangular channel (m)
    %   Re - Reynolds
    %   A - Area (m^2)
    %   head (Pa)

A = W * H; % m^2
velocity = flow / A * (1 / 1000 / 60); % m^3/s
Dh = 2 * W * H / (W + H); % m
Re = rho * velocity * Dh / mu; % dimensionless
    for i = 1:length(Re);
       if Re(i) < 2000; % Laminar flow
       %    REFERENCE
       % Q. Ye, J. Hu, P. Cheng, and Z. Ma, 
       % “Design trade-offs among shunt current, pumping loss and 
       % compactness in the piping system of a multi-stack vanadium 
       % flow battery,” Journal of Power Sources, vol. 296, pp. 352–364,
       % Aug. 2015, doi: 10.1016/j.jpowsour.2015.06.138 
            Csc = 55.5 + 40.9 * 0.3 ^(H / W);
            fd(i) = Csc / Re(i);
            hRectangular(i) = fd(i) * L * rho * velocity(i) ^ 2 / (2 * Dh); % Pa

       else 2000 < Re(i) < 4000; % Transient flow (Churchill-Bernstein equation)
            Achurchill = 2.457 * log((7 / Re(i)) ^ 0.9 + 0.27 * (e / Dh)) ^ 16;
            Bchurchill = (37530 / Re(i)) ^ 16;
            fd(i) = 8* ((8 / Re(i)) .^ 12 + (Achurchill + Bchurchill) ^ (-1.5)) ^ (1 / 12);
            hRectangular(i) = fd(i) * L * rho * velocity(i) ^ 2 / (2 * Dh); % Pa
       end

    end   

head = hRectangular; % Pa
end