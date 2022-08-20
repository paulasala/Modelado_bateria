function [point] = OP(ecuA, ecuB)


% Intersección de dos rectas da como resultado una ecuación de segundo grado:
    pol = [(ecuA(1) - ecuB(1)) (ecuA(2) - ecuB(2)) (ecuA(3) - ecuB(3))];
    r = roots(pol)

% Selección de punto para que esté en el primer cuadrante
    if r(1) > 0;
        x = r(1)
        y = ecuB(1) * x^2 + ecuB(2) * x + ecuB(3)
    else r(2) > 0;
        x = r(2)
        y = ecuB(1) * x^2 + ecuB(2) * x + ecuB(3)
         
    end
point = [x y]
 end
