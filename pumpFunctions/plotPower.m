function []= plotPower (flow, data)
    % qInstallationValues - vector with flow values of the installation
    % hInstallationValues - vector with head values of the installation
    % (same size of qInstallation)
    % data is a struct
figure()

% idx = [data.name] > 0; % logic vector with valid 1 and non valid 0 
% position = find(idx); % find the position on the struct of the valid pumps
% leg = cell(1,length(position + 1));
% leg{1} = 'Instalacion';
%     for i = 1: length (position)
num = length(data.name)
leg = cell(1,length(data.name));
    for i = 1: length (data.name)
        plot (flow.tot,data(i).powerReal)
        leg{i+1} = [data(i).name];        
    end
    legend(leg,'location','best');
    ylabel('Power [W]')
    grid on
    title('Battery power-flow')
    xlabel('Flow [l/min]')
    
hold off
end