function hMinorStack = hMinorLossesStack(rho, Qcell, H, W, HChannelBetweenRibs, WChannelBetweenRibs, numberOfHolesBetweenRibs)
% HEAD DUE TO MINOR LOSSES
%   Pressure losses due to the change of section between manifold and channels in the frames
    % areaChannelBetweenRibs - Area of a rib
    % HChannelBetweenRibs - (m)
    % WChannelBetweenRibs - (m)
    % velocityChannel - velocity of the flow in the channel between ribs
    % Q - l/min
  
% PAGINA 437 Munson B. et Al.
    areaManifold = H * W; % m^2
    areaChannelBetweenRibs = HChannelBetweenRibs * WChannelBetweenRibs; % Area of the channel between ribs (m^2)

% The loss coefficient for a SUDDEN CONTRACTION can be obtain from the
% figure 8.26 of Munson B., et al.(pag 460) 
    % coef =  areaChannelBetweenRibs / areaManifold 
    kLinput = 0.5;
% The pressure drop can be calculated as: hL = kL * velocityOutput^2/(2*g) For a sudden contraction
    velocityChannelBetweenRibs = Qcell / numberOfHolesBetweenRibs / areaChannelBetweenRibs / (1000 * 60); % (m/s)
    hLinput = kLinput * 1/2 * rho * velocityChannelBetweenRibs .^ 2; % Pa = kg/(m*s^2)

% The loss coefficient for a SUDDEN EXPANSION can be theoretically
% calculated as: kLoutput = (1 - AREAflowInput/AREAflowOutput)^2
    kLoutput = (1 - areaChannelBetweenRibs / areaManifold) ^ 2; % Loss coefficient for a SUDDEN EXPANSION
    hLoutput = kLoutput * 1/2 * rho * velocityChannelBetweenRibs .^ 2;  % Pa = kg/(m*s^2)

hMinorStack = hLoutput + hLinput; % Pa

end