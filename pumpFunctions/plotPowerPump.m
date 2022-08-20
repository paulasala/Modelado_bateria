function []= plotPowerPump (dataPower, dataBattery, flow, head)
    % qInstallationValues - vector with flow values of the installation
    % hInstallationValues - vector with head values of the installation
    % (same size of qInstallation)
    % data is a struct

    for i = 1: length (dataPower)
    powerBattery = figure();
    tiledlayout(1,2,'TileSpacing','Compact');

    nexttile(1)
        %plot(dataPower(i).pImpeller, 'LineWidth', 2)
        plot(dataPower(i).pPump, 'LineWidth', 2)
        hold on
        
        plot(dataPower(i).pMotor, 'LineWidth', 2)
        plot(dataPower(i).pVariador, 'LineWidth', 2)
        
        plot(dataPower(i).powerReal, 'LineWidth', 2)
        plot(dataPower(i).pHydraulicSystem, 'LineWidth', 2)


        ylabel('Power [W]')
        grid on
        ylim([0 700])

        title('Battery power-flow',dataPower(i).name)
        xlabel({'Time [s]'; '(a)'})
        legend({'Impeller+magnetic drive','Motor','Inverter','Negative electrolite circuit','Hydaulic system'},'location','northwest')

    nexttile(2)
        plot (abs(dataBattery.pHistoric), 'LineWidth', 2)
        hold on
        plot(dataPower(i).pHydraulicSystem, 'LineWidth', 2)
        ylabel('Power [W]')
        grid on
        title('Battery power',dataPower(i).name)
        xlabel({'Time [s]'; '(b)'})
        ylim([0 13000]);
        legend({'Battery power','Hydraulic system power'},'location','west')
        hold off

 changeFig(powerBattery, dataPower(i).name, 2);


    end
end