function []= plotSpeedRate (data, data2,data3,flow,dataBattery)
    % qInstallationValues - vector with flow values of the installation
    % hInstallationValues - vector with head values of the installation
    % (same size of qInstallation)
    % data is a struct

    for i = 1: length (data)
    Speed = figure();
    tiledlayout(2,2,'TileSpacing','Compact');

    nexttile(1)
        plot(data2(i).nRate, 'LineWidth', 2)
        hold on
        %plot(data(i).nRate, 'LineWidth', 2)
        %plot(data3(i).nRate, 'LineWidth', 2)
        ylabel('Speed rate [-]')
        grid on
                
        title('Rate', data(i).name)
        xlabel({'Time [s]'; '(a)'})
        hold off

        %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
        %legend('Δ Equations', 'Δ Affinity laws','location','northwest')

%Plot power Impeller
%     nexttile(5)
%         %plot(data2(i).powerImpeller, 'LineWidth', 2)
%         hold on
%         plot(data(i).powerImpeller, 'LineWidth',2)
%         plot(data3(i).powerImpeller, 'LineWidth', 2)
%         ylabel('Power impeller [W]')
%         grid on
% 
%         %title('Power Impeller', data(i).name)
%         xlabel({'Time [s]'; '(e)'})
%         hold off
%         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         legend('Δ Equations', 'Δ Affinity laws','location','northwest')

%Plot power Hydraulic system
%         nexttile(6)
%         plot(data2(i).powerReal, 'LineWidth', 2)
%         hold on
%         %plot(data(i).powerReal, 'LineWidth', 2)
%         %plot(data3(i).powerReal, 'LineWidth', 2)
%         ylabel('Real Power [W]')
%         grid minor
% 
%         %title('Power Real', data(i).name)
%         xlabel({'Time [s]'; '(f)'})
%         hold off
%         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         %legend('Δ Equations', 'Δ Affinity laws','location','northwest')

%Plot rendimiento bomba vs flow
%         nexttile(2)
%         plot(flow.tot,data2(i).nRdto, 'LineWidth', 2)
%         hold on
%         %plot(flow.tot,data(i).nRdto, 'LineWidth', 2)        
%         %plot(flow.tot,data3(i).nRdto, 'LineWidth', 2)
%         ylabel('Rdto pump [%]')
%         %ylim([55 70])
%         grid minor
% 
%         %title('Rdto pump vs flow', data(i).name)
%         xlabel({'Flow battery [l/min]'; '(b)'})
%         hold off
%         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         %legend('Δ Equations', 'Δ Affinity laws','location','southwest')

%Plot rendimiento bomba 
%         nexttile(2)
%         plot(data2(i).nRdto, 'LineWidth', 2)
%         hold on
%         %plot(data(i).nRdto, 'LineWidth', 2)        
%         plot(data3(i).nRdto, 'LineWidth', 2)
%         ylabel('Rdto pump [%]')
%         %ylim([55 70])
%         grid on
% 
%         %title('Rdto pump', data(i).name)
%         xlabel({'Time [s]'; '(b)'})
%         hold off
%         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         %legend('Δ Equations', 'Δ Affinity laws','location','southwest')

%Plot Nprima 
        nexttile(2)
        plot(data2(i).nPrimaHz, 'LineWidth', 2)
        hold on
        %plot(data(i).nPrima, 'LineWidth', 2)        
        %plot(data3(i).nPrima, 'LineWidth', 2)
        ylabel('Frequency [Hz]')
        grid on

        title('Frequency', data(i).name)
        xlabel({'Time [s]'; '(b)'})
        hold off
         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
        %legend('Δ Equations', 'Δ Affinity laws','location','northwest')

% %Plot RPM bomba vs flow
%         nexttile(2)
%         plot(flow.tot,data2(i).nPrima, 'LineWidth', 2)
%         hold on
%         %plot(flow.tot,data(i).nPrima, 'LineWidth', 2)        
%         %plot(flow.tot,data3(i).nPrima, 'LineWidth', 2)
%         ylabel('Speed pump [rpm]')
%         grid on
%         
%         %title('Rdto pump vs flow', data(i).name)
%         xlabel({'Flow battery [l/min]'; '(b)'})
%         hold off
%         %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         %legend('Δ Equations', 'Δ Affinity laws','location','southeast')
%     
% 
% %Plot frequency of the pump
%         nexttile(4)
%         plot(data2(i).nPrimaHz, 'LineWidth', 2)
%         hold on
%         %plot(data(i).nPrimaHz, 'LineWidth', 2)        
%         %plot(data3(i).nPrimaHz, 'LineWidth', 2)
%         ylabel('Frequency [Hz]')
%         grid minor
% 
%         %title('Frequency', data(i).name)
%         xlabel({'Time [s]'; '(d)'})
%         hold off
%          %legend('Variación de las ecuaciones','Mix puntos homologos y variación ecuaciones', 'Variación con puntos homologos')
%         %legend('Δ Equations', 'Δ Affinity laws','location','northwest')

   nexttile(3)
        %plot(dataPower(i).pImpeller, 'LineWidth', 2)
        plot(data2(i).pPump, 'LineWidth', 2)
        
        plot(data2(i).powerReal, 'LineWidth', 2)
              hold on
        plot(data2(i).pHydraulicSystem, 'LineWidth', 2)

        ylabel('Power [W]')
        grid on
        %ylim([0 1000])

        title('Battery power-flow',data(i).name)
        xlabel({'Time [s]'; '(c)'})
        legend({'Pump','Hydaulic system'},'location','northwest')

    nexttile(4)
        plot (abs(dataBattery.pHistoric), 'LineWidth', 2)
        hold on
        plot(data2(i).pHydraulicSystem, 'LineWidth', 2)
        ylabel('Power [W]')
        grid on
        title('Battery power',data(i).name)
        xlabel({'Time [s]'; '(d)'})
        ylim([0 13000]);
        legend({'Battery power','Hydraulic system power'},'location','west')
        hold off

        changeFig(Speed, data2(i).name, 4);

changeFig(Speed, data(i).name, 4);

    end
end