whichModel = 'Model';
%whichModel = 'Naive'

for expnum = 2:3
    name = strcat('NearNeighbor', whichModel, 'Exp', num2str(expnum));
    s = load(strcat(name, 'StandardDev', '.csv'));
    t = load(strcat(name, 'Average', '.csv'));
    
    %saving both png and figs of each
    plotSelectedErrorbars(t, s, name, 20, 0.05);
end
