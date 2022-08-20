function coeficientePoly = createPumpPoly(dataExcel, degreeFunction)
% PUMP EQUATION
%   Ecuacion de la bomba obtenida desde la tabla Excel

% Q is Flow and H is Head
    Q = dataExcel(:, 1) .* 1000 ./60;  % data: (Q: m^3/h) -> (Q: L/min)
    H = dataExcel(:, 2) .* 9.81 .* 1000 ./1000;  % data: (H: mca) -> (H: kPa) 

% Equation NO scaled. 
    % To obtain error estimates. 2 values [p,S] = polyfit(x,y,n)
    % In case of scale return 3 values [p,S,mu] = polyfit(x,y,n)
    coeficientePoly = polyfit(Q, H, degreeFunction);
end