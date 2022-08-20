function coefficientEfficiency = createPolyEfficiency(dataExcel, degreeFunction)
% PUMP EQUATION
%   Ecuacion de la bomba obtenida desde la tabla Excel

% Q is Flow and H is Head
    Q = dataExcel(:, 3); 
    efficiency = dataExcel(:, 4); 

% Equation NO scaled. 
    % To obtain error estimates. 2 values [p,S] = polyfit(x,y,n)
    % In case of scale return 3 values [p,S,mu] = polyfit(x,y,n)
    coefficientEfficiency = polyfit(Q, efficiency, degreeFunction);
end