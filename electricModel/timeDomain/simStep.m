function [bat] = simStep(i_k, bat, deltaT)
%SIMSTEP Summary of this function goes here
    % i_k - current in a specific SoC (k)       [A]
    % bat - struct with data from it
    % deltaT - increment of time in seconds 
    % rc_exp - resistance
    % etai_k - energy

    i_k = -i_k; % current
    rc_exp = exp(-deltaT./bat.rc); % resistance
     
%apply efficiency on charge:
    
    etai_k = i_k; 
    etai_k(i_k<0) = bat.etaChg * i_k(i_k<0);

    %soc integration
    z_k1 = bat.z_k - deltaT / (bat.Q*3600) * etai_k * bat.cells;

    %compute dynamic current trough RC pairs
    irn_k1 = rc_exp .* bat.irn_k + (1-rc_exp) * i_k;

    %compute output v
    bat.v_k = (interp1(bat.soc, bat.ocv, bat.z_k)*bat.cells - bat.r0 * i_k - bat.rn .* bat.irn_k); 
        %interpolaciones que relacionan el SoC con el estado de carga

    %update status
    bat.irn_k = irn_k1;
    bat.z_k = z_k1;

    %Historic data for analysis
    bat.vHistoric = [bat.vHistoric, bat.v_k];
    bat.zHistoric = [bat.zHistoric, bat.z_k];
    bat.pHistoric = [bat.pHistoric, bat.v_k * -i_k];
    bat.iHistoric = [bat.iHistoric, -i_k];
end

