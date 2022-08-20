function [Apoint, OAecu, aEndPoly] = parallelDifferentPumps (ecuA, ecuB)
% ecuA - equation of one pump
% ecuB - equation of a different pump


%   Selection of the highest H between the two pumps H = A*q^2 + B*q + C
    %   It occures when (q=0), then H(q=0) = C: so, it is compare the C
    %   value of the two pumps.
if ecuA(3) < ecuB(3) 
    OAecu = ecuB;
    p = [ecuB(1) ecuB(2) [ecuB(3) - ecuA(3)]]; % POINT A
    r = roots(p); %  Possible solutions
    if r(1) > 0; % Selection of the solution of the point A in the first quadrant
        xPoint = r(1);
        yPoint = ecuA(3);
    else r(2) > 0;
        xPoint = r(2) ;
        yPoint = ecuA(3);
    end
else ecuB(3) > ecuA(3);
     OAecu = ecuA;
    p = [ecuA(1) ecuA(2) [ecuA(3) - ecuB(3)]]; % POINT A
    r = roots(p);
    if r(1) > 0; % Selection of the solution in the first quadrant
        xPoint = r(1);
        yPoint = ecuB(3);
    else r(2)> 0;
        xPoint = r(2);
        yPoint = ecuB(3);
    end
end

    Apoint = [xPoint,yPoint]; % POINT A (crossing point between both pumps)

        %%%%%%%%%%%%%%%%%%%%%  OA plot  %%%%%%%%%%%%%%%%%%%%%

%        xNumbersAboveCutoffPoint = linspace (0,xPoint, 50)';     
%     if ecuA(3) < ecuB(3); 
%         yPointsSectionOA = ecuB(1) * xNumbersAboveCutoffPoint .^ 2 + ecuB(2) * xNumbersAboveCutoffPoint + ecuB(3);  
%         plot (xNumbersAboveCutoffPoint,yPointsSectionOA) 
%     else ecuB(3) > ecuA(3);
%         yPointsSectionOA = ecuA(1) * xNumbersAboveCutoffPoint .^2 + ecuA(2) * xNumbersAboveCutoffPoint + ecuA(3);  
%         plot (xNumbersAboveCutoffPoint,yPointsSectionOA)
%     end
        %%%%%%%%%%%%%%%%%%%%%  OA plot  %%%%%%%%%%%%%%%%%%%%%

 % A-end: it is necessary to obtain three points of the pumps
 % Point A, it was obtain preiously, it's where cutoff point occure:
    hCBA= linspace(0,yPoint,3)'; % Generates a vector of three points where height is: [ 0 puntoMedio hMax]
    qA = xPoint;

% Flow in point B:
    qBPumpAplus = ( - ecuA(2) + sqrt(ecuA(2)^2 - 4*ecuA(1)*(ecuA(3) - hCBA(2)))) / (2*ecuA(1));
    qBPumpBminus = ( - ecuB(2) - sqrt(ecuB(2)^2 - 4*ecuB(1)*(ecuB(3) - hCBA(2)))) / (2*ecuB(1));
    qBPumpBplus = ( - ecuB(2) + sqrt(ecuB(2)^2 - 4*ecuB(1)*(ecuB(3) - hCBA(2)))) / (2*ecuB(1));
    qBPumpAminus = ( - ecuA(2) - sqrt(ecuA(2)^2 - 4*ecuA(1)*(ecuA(3) - hCBA(2)))) / (2*ecuA(1));
    % Evaluation of the equation sign
    if (qBPumpAplus >0 & qBPumpBminus > 0);
        qB = qBPumpAplus + qBPumpBminus;
    elseif (qBPumpAminus > 0 & qBPumpBminus > 0);
        qB = qBPumpAminus + qBPumpBminus;
    elseif (qBPumpAplus > 0 & qBPumpBplus > 0);
        qB = qBPumpAplus + qBPumpBplus;
    else (qBPumpAminus > 0 & qBPumpBplus > 0);
        qB = qBPumpAminus + qBPumpBplus;
    end

% Flow in point C:
    qCPumpAplus = ( - ecuA(2) + sqrt(ecuA(2)^2 - 4*ecuA(1)*(ecuA(3) - hCBA(1)))) / (2*ecuA(1));
    qCPumpBminus = ( - ecuB(2) - sqrt(ecuB(2)^2 - 4*ecuB(1)*(ecuB(3) - hCBA(1)))) / (2*ecuB(1));
    qCPumpBplus = ( - ecuB(2) + sqrt(ecuB(2)^2 - 4*ecuB(1)*(ecuB(3) - hCBA(1)))) / (2*ecuB(1));
    qCPumpAminus = ( - ecuA(2) - sqrt(ecuA(2)^2 - 4*ecuA(1)*(ecuA(3) - hCBA(1)))) / (2*ecuA(1));
    % Evaluation of the equation sign
    if (qCPumpAplus >0 & qCPumpBminus > 0);
        qC = qCPumpAplus + qCPumpBminus;
    elseif (qCPumpAminus > 0 & qCPumpBminus > 0);
        qC = qCPumpAminus + qCPumpBminus;
    elseif (qCPumpAplus > 0 & qCPumpBplus > 0);
        qC = qCPumpAplus + qCPumpBplus;
    else (qCPumpAminus > 0 & qCPumpBplus > 0);
        qC = qCPumpAminus + qCPumpBplus;
    end    

q = [qC qB qA]';
aEndPoly = polyfit(q,hCBA, 2); % Equation of the two pumps working together

        %%%%%%%%%%%%%%%%%%%%%  A-End plot  %%%%%%%%%%%%%%%%%%%%%
% valoresAend = polyval(aEndPoly, xPoint:qC)';
% valoresCaudal = (xPoint:qC)';
% 
% hold on
% plot(valoresCaudal,valoresAend)
% hold off
        %%%%%%%%%%%%%%%%%%%%%  A-End plot  %%%%%%%%%%%%%%%%%%%%%
end
 