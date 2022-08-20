function [ecu, OP, numberOfPumpsNeedIt] = numEqualParallel(maxOperatingPoint, flowValues, headValues, ecuPump, ecuInstalation, numPumpsMax)
% NUMBER OF PUMPS IN PARALLEL
    % flowOPMaxParallelEqual - flow operational point maximum that reach the pumps with the instalation 

%   Initialization:

        contadorPumps = 0;
        parallelEquals = 0;
        OPmaxParallel = 0;

        flowOPMax = maxOperatingPoint(1);
        headOPMax = maxOperatingPoint(2);

%   Obtain the number of pumps need it to reach the OP
    while  flowOPMax < max(flowValues) & headOPMax < max(headValues) & contadorPumps < numPumpsMax
        contadorPumps = contadorPumps + 1;
        parallelEquals = parallelEqualPumps(ecuPump, contadorPumps); % Create the ecuation of two equal pumps in serie
        OPmaxParallel = intersectionPoint(parallelEquals, ecuInstalation);
        % Actualization of the values
        flowOPMax = OPmaxParallel(1);
        headOPMax = OPmaxParallel(2);

        %%%%%%%%%%%%%%%%%%%%%%% grafica %%%%%%%%%%%%%%%%%%%%%%%%%%%
        % qPump = [0:10:200];
        % pumpHEAD = polyval(parallelEquals, qPump);
        % hold on
        % plot(qPump, pumpHEAD)
        % hold off
        %%%%%%%%%%%%%%%%%%%%%%% grafica %%%%%%%%%%%%%%%%%%%%%%%%%%%

    end


    if headOPMax > max(headValues) & flowOPMax > max(flowValues)
        numberOfPumpsNeedIt = contadorPumps;
     else
         numberOfPumpsNeedIt = -1;
     end
        ecu = parallelEquals;
        OP = OPmaxParallel;


end