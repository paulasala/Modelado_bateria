function validIndividualPump = validPumpLimit(operatingPointMax, flowValues, instalationValues, i)
% CLASSIFICATION OF A PUMP IN VALID AND INVALID
% Function that classifies each pump as valid (1) and invalid (0) to 
% operate on its own if it reaches the maximum operating point. 

    % operatingPointMax: maxOperationPoint(1) = flow , maxOperationPoint(2) = head 
    % flowValues - values of the required flow
    % instalationValues - values of the hydraulic instalation
    % i - porcentage limit of a valid flow and head of a pump (ej 1.1) 
        % ej: i = 1.1 the upper limit will be flow*1.1 and head*1.1

% Comprobation values    
%     operatingPointMax % QUITAR LUEGO
%     flowValues(end)
     flowUpperLimit = max(flowValues)* i;
%     instalationValues(end)
     instalationUpperLimit = max(instalationValues) * i;

    % Classification of the minimum Operating Point that should reach.
    if operatingPointMax(1) > max(flowValues) & operatingPointMax(2) > max(instalationValues) & operatingPointMax(1) < flowUpperLimit & operatingPointMax(2) < instalationUpperLimit
        validIndividualPump = 1; % VALID PUMP
    else
        validIndividualPump = -1; % NOT VALID PUMP
    end

 end