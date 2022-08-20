function [rdto] = efficiency(ecuEfficiency,OP)
% Gives the efficiency of a pump working in an especific operational point

%   ecuEfficiency - Efficiency equation
%   OP - Operational point (flow, head)

 rdto = ecuEfficiency(1) * OP(1) ^ 2 + ecuEfficiency(2) * OP(1) + ecuEfficiency(3);
end