function [point] = intersectionPoint(ecuA, ecuB)


% Intersección de dos rectas da como resultado una ecuación de segundo grado:
 % x = ax^2 + bx + c
 % x = [-b ± (b^2 - 4ac)^(1/2)] / 2a


 % x= [-b + (b^2 - 4ac)^(1/2)] / 2a
    x = (-(ecuA(2) - ecuB(2)) + sqrt((ecuA(2) - ecuB(2)) ^ 2 - 4 * ((ecuA(1) - ecuB(1)) * (ecuA(3) - ecuB(3))))) / (2 * (ecuA(1) - ecuB(1)));
    y = x ^ 2 * ecuA(1) + x * ecuA(2) + ecuA(3);

% x= [-b - (b^2 - 4ac)^(1/2)] / 2a
    xs = (-(ecuA(2) - ecuB(2)) - sqrt((ecuA(2) - ecuB(2))^2 - 4 * ((ecuA(1) - ecuB(1)) * (ecuA(3) - ecuB(3))))) / (2 * (ecuA(1) - ecuB(1)));
    ys = xs ^ 2 * ecuA(1) + xs * ecuA(2) + ecuA(3);

% Selección de punto para que esté en el primer cuadrante
    if x > 0  & y > 0;
        point = [x y]; 
    else xs > 0 & ys > 0;
        point = [xs ys];
    end

 end
