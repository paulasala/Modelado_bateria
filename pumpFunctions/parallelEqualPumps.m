function paralelEqualPumps = parallelEqualPumps(coeficientePol, numPumps)
% EQUAL PUMPS IN PARALLEL EQUATION
%   Equation of the pumps in parallel
    % Hn= a1/(n^2) * q^2 + a2/n * q + a3

    exponent = length(coeficientePol);

    for position = 1 : length(coeficientePol)
        exponent = exponent - 1;
        result = coeficientePol(position) / numPumps^(exponent);

        paralelEqualPumps(position) = [result];
    end
end