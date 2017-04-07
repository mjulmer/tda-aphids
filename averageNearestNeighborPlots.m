%You DO still need to change the some paths because of my terrible naming
%conventions; 'PlotExp' means naive for loading each run
whichModel = 'Model';
%whichModel = 'Naive'

for expnum = 1:9
    if expnum == 4 %because there are NaN's in exp 4 data that screw things up
        continue
    end

    %gets average of all runs of the simulated data
    all_runs = load(strcat('nearNeighborModelExp', num2str(expnum), 'run1.csv'));
    %all_runs = load(strcat('nearNeighborPlotExp', num2str(expnum), 'run1.csv'));
    for runnum = 2:100
        %current_run = load(strcat('nearNeighborPlotExp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        current_run = load(strcat('nearNeighborModelExp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        all_runs = cat(3, all_runs, current_run);
        runnum
    end
    
    name = strcat('NearNeighbor', whichModel, 'Exp', num2str(expnum));
    
    s = std(all_runs, 0, 3);
    csvwrite(strcat(name, 'StandardDev', '.csv'), s)
 
    t = mean(all_runs, 3);
    csvwrite(strcat(name, 'Average', '.csv'), t)
    
    %saving both png and figs of each
    makeOrderParamPlotAxes(s, strcat(name, 'StandardDev', '.png'), 0.2);
    makeOrderParamPlotAxes(s, strcat(name, 'StandardDev'), 0.2);
    makeOrderParamPlotAxes(t, strcat(name, 'Average', '.png'), 0.2);
    makeOrderParamPlotAxes(t, strcat(name, 'Average'), 0.2);

end