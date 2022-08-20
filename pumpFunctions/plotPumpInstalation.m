function []= plotPumpInstalation (ecuInstalation, data)
    % qInstallationValues - vector with flow values of the installation
    % hInstallationValues - vector with head values of the installation
    % (same size of qInstallation)
    % data is a struct
figure
qPump = [0:5:500];
    hold on
    hInstalation = polyval(ecuInstalation, qPump);
    plot(qPump, hInstalation, 'LineWidth', 1.5)
idx = [data.validLimit] > 0; % logic vector with valid 1 and non valid 0 
position = find(idx); % find the position on the struct of the valid pumps
leg = cell(1,length(position + 1));
leg{1} = 'Facility';
    for i = 1: length (position)
        j = position(:, i);
        hPump = polyval(data(j).eq, qPump);
        plot(qPump, hPump, 'LineWidth', 1.5)
        ylim([0 500])
        xlim([0 500])
%         ecu = @(x) data(j).eq(1) * x^2 + data(j).eq(2) * x + data(j).eq(3);
%         lim = fzero (ecu,[1 500]);
%         fplot(ecu,[0,lim]);
        leg{i+1} = [data(j).name];        
    end
    legend(leg,'location','eastoutside');
    xlabel('Flow (l/min)') ;
    ylabel('Head (kPa)'); 
    
hold off
end