function headFrames = hFrames (dataExcel, Qcell)
% PUMP EQUATION
%   Ecuacion de la bomba obtenida desde la tabla Excel

% Q is Flow and H is Head
    Q = dataExcel(:, 6); 
    lossesFrames = dataExcel(:, 7); 

% Equation NO scaled. 
    % To obtain error estimates. 2 values [p,S] = polyfit(x,y,n)
    % In case of scale return 3 values [p,S,mu] = polyfit(x,y,n)
    createPolyLosses = polyfit(Q, lossesFrames, 2);
    headFrames = Qcell.^2*createPolyLosses(1) + Qcell*createPolyLosses(2) + createPolyLosses(3);
end