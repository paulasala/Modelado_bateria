function [fig] = changeFig(fig, figName, numFigures)
%CHANGEFIG Summary of this function goes here
%   Detailed explanation goes here
%   Figname --> 'nombre_ejemplo'
set(findobj(fig,'type','axes'),'FontName','Calibri','FontSize',15, 'LineWidth', 2);

fname = 'G:\.shortcut-targets-by-id\19rV0QRJLoob7cxp3i5p4hv0msW7X7Ll2\08_TFG_PAULA\03_MATLAB\imagenes';

if numFigures == 1;
    set(findobj(fig,'type','axes'),'FontName','Calibri','FontSize',12, 'LineWidth', 1.3);
    set(fig, 'position',[0 0 200*4/3 200]);
elseif numFigures == 1.5;
    set(findobj(fig,'type','axes'),'FontName','Calibri','FontSize',12, 'LineWidth', 1.3);
    set(fig, 'position',[0 0 250*4/3 200]);    
elseif numFigures == 2;
    set(fig, 'position',[0 0 700*4/3 700/2]);
elseif numFigures == 3;  
    set(fig, 'position',[0 0 825*4/3 825/3]);    
elseif numFigures == 4;
    set(findobj(fig,'type','axes'),'FontName','Calibri','FontSize',15, 'LineWidth', 2);
        set(fig, 'position',[0 0 700*4/3 700]);
elseif numFigures == 6;
    set(findobj(fig,'type','axes'),'FontName','Calibri','FontSize',15, 'LineWidth', 1.3);
        set(fig, 'position',[0 0 700 700*4/3]);        
end


saveas(fig, fullfile(fname, figName), 'meta')
end