function efficiency = efficiencyPump(coefficientEfficiency, q)
% EFFICIENCY PUMP
% efficiency = A*q^3 + B*q^2 + C*q^1 + D

result = 0;
exponent = length(coefficientEfficiency);

    for position = 1 : length(coefficientEfficiency)
        exponent = exponent - 1;
        result = q^exponent * coefficientEfficiency(position) + result;


    end
    efficiency = result;

end