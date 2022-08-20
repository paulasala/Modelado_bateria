function [ecu, OP, numberOfPumpsNeedIt] = numEqualSerie(maxOperatingPoint, flowValues, headValues, ecuPump, ecuInstalation, numPumpsMax)
% NUMBER OF PUMPS THAT ARE NEEDED IN SERIE TO REACH THE MAXIMUM OPERATIONAL POINT
    % It´s obtain the equivalence of the necessary pumps, the maximum
    % operational point

%   Initialization:
    contadorPumps = 0;
    OPserieEqual = 0;
    ecuSeriePumpsEquals = 0;

flowOPmax = maxOperatingPoint(1);
headOPmax = maxOperatingPoint(2);
    
% Boundary condition to obtain the number of pumps need it
   % It's necessary to reach the maximum operating point and limit the 
   % number of pumps that can be used, since sometimes the maximum 
   % operational point is not going to be reach
         while headOPmax < max(headValues) & flowOPmax < max(flowValues) & contadorPumps < numPumpsMax
            contadorPumps = contadorPumps + 1;
            ecuSeriePumpsEquals = serieEqualPumps(ecuPump, contadorPumps); % Create the ecuation of two equal pumps in serie
            OPserieEqual = intersectionPoint(ecuSeriePumpsEquals, ecuInstalation);

            headOPmax = OPserieEqual(2); 
            flowOPmax = OPserieEqual(1);
         end 

         %numberOfPumpsNeedIt = contadorPumps;
         OP = OPserieEqual;
         ecu = ecuSeriePumpsEquals;

    %   Selection of the data
         if headOPmax > max(headValues) & flowOPmax >  max(flowValues)
            numberOfPumpsNeedIt = contadorPumps;
         else
             numberOfPumpsNeedIt = -1;
         end
end

