function [experiment, electrolite, electrode, manifold, frame, nCell, nStacks, SoCmax, SoCmin, pipe, comertialElements, limitPump, rto] = initValues()
% initValues 
%   Initial Values for the battery

%---- nCell- number of cells
    nCell               = 20;
    nStacks             = 4; 

%---- Flow inicialization
    experiment.FF       = 6;    % flow factor
    SoCmin              = 0.2;
    SoCmax              = 0.9;
    experiment.SoC      = (SoCmin : 0.05 : SoCmax)'; %points every 0.5%
    experiment.J        = 0.08; % (A/cm2) -> current density

%---- Electrolite properties
    electrolite.mu      = 4.93*10^(-3); % Pa*s
    electrolite.rho     = 1354; % (kg/m^3)
    electrolite.g       = 9.81; % (m/s^2)
    electrolite.cv      = 1.65; % (mol V/L)

%---- Electrode 
    % properties
    electrode.df        = 9*10 ^(-6); % m (diametre of fiber)
    electrode.ePorosity = 0.9;  % electrode porosity
    electrode.cteCK     = 4.28; % constante de Kozeny-Carman

    % dimensions
    electrode.We        = 0.4;  % m ancho
    electrode.Le        = 0.4;  % m largo 
    electrode.He        = 0.003;% m espesor

%---- Manifold parameters
    manifold.W          = 180*10^(-3);  % m ancho
    manifold.H          = 24 * 10^(-3); % m alto
    manifold.L          = 263 * 10^(-3);% m largo valor obtenido de INVENTOR
    manifold.e          = 0.0015;       % Pipe roughtness, it's low since PVC material
    manifold.hManifold  = 460* 10 ^(-3);% m Distance between Input Collector and Output Collector

%---- Values of the frame's ribs
    frame.HchannelBetweenRibs       = 1*10^(-3);  % m
    frame.WchannelBetweenRibs       = 25*10^(-3); % m
    frame.LchannelBetweenRibs       = 18*10^(-3); % m
    frame.numberOfHolesBetweenRibs  = 6;


%-------------------- PIPE VALUES ----------------

%   Initial Values of the pipe system diametre 1/2
%----Pipe internal roughness 
    pipe.epsilon = 0.0015 * 10^(-3); % m [PVC (Pipe Internal Roughness absoluta SHASHI MENON PAG 16)]

%----Diameter value
    pipe.diameter = 0.0426; % m Diametro interno
    pipe.area = pi * (pipe.diameter / 2) ^ 2; % m^2
    
%----Piping measurements in metre (Medidas medidas presencialmente)
    %----Piping 4Qstack
        pipe.L1 = 0.17 + 0.6 + 0.2;
        pipe.L2 = 0.1;     
        % Bypass
        pipe.L3 = 0.34 + 1.95; % Roja
        pipe.L17 = 1.25 + 0.3 + 0.64;
        pipe.L11 = 0.22 + 0.4;
    %----Piping 2Qstack
        pipe.L4 = 0.2; % Verde
        pipe.L6 = 0.36 + 0.16;
        pipe.L16 = 0.25;
    %----Piping Qstack
        pipe.L7 = 0.3;
        pipe.L8 = 0.65 + 0.3;
        pipe.L9 = 0.4;
        pipe.L10 = 0.5 + 0.6;
        pipe.L12 = 0.3;
        pipe.L13 = 0.65 + 0.3;
        pipe.L14 = 0.5 + 0.6;
        pipe.L15 = 0.4;

%----Longitudes de las tuberías para los caudales dependiendo del tramo
pipe.L2Q = pipe.L1 + pipe.L2 + pipe.L3 + pipe.L6 + pipe.L11 + pipe.L17;
pipe.LQ = pipe.L8 + pipe.L10;

%----Constant values of comertial %pag 27 Shashi Menon
    comertialElements.kValve = 0.22;
    comertialElements.kValve3Way = 0.81;
    comertialElements.kValveStraightway = 0.49;
    comertialElements.kBallValve = 0.08;
    comertialElements.kElbow90 = 0.81;
    comertialElements.kLongRadius90 = 0.43;
    comertialElements.kT = 0.54; % Standard tee through-flow 

    

%-------------------- PUMP --------------------

%---- Limits in selection pumps
    limitPump.numMax    = 4;    % Maximum number of pumps acceptable
    limitPump.upper     = 1.5;  % Flow and head limit of the pumps

%---- Efficiency values
    rto.Motor           = 0.85;  % Motor IE3 Premium Efficiency
    rto.AFD             = 0.85;   % Variable frequency drive
    
end
