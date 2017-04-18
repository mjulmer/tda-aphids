for expnum = 2:3
    
    names = {'polarPlotNaive', 'angPlotNaive', 'absPlotNaive', 'polarPlotModel', 'angPlotModel', 'absPlotModel'};
    for indx = 1:6
        name = strcat(names{indx}, 'Exp', num2str(expnum));
        s = load(strcat(name, 'StandardDev', '.csv'));
        t = load(strcat(name, 'Average', '.csv'));
        
        %saving both png and figs of each
        plotSelectedErrorbars(t, s, name, 20, 0.5);
        
        
    end
    
end