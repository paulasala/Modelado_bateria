function hMinor = hMinorLosses(rho, Qcell, HChannelBetweenRibs, WChannelBetweenRibs, numberOfHolesBetweenRibs)
% HEAD DUE TO MINOR LOSSES
%   Change of section between Manifold channel and frames
    % aChannelBetweenRibs - Area of a rib
    % HChannelBetweenRibs - 
    % WChannelBetweenRibs -
    % fMinor -
    % velocityChannel - velocity of the flow in the channel between ribs
    fMinor = 9.8; % Se escoge por ser un valor pequeño PAPER 5

    aChannelBetweenRibs = HChannelBetweenRibs*WChannelBetweenRibs; % Area of a rib (m^2)
    velocityChannelBetweenRibs = Qcell./numberOfHolesBetweenRibs./aChannelBetweenRibs/(1000*60); % (m/s)
hMinor = fMinor * (rho * velocityChannelBetweenRibs.^2)/2; % Pa = kg/(m*s^2)

end