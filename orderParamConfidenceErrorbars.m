orderParams = {'ang', 'abs', 'polar', 'nearNeighbor'};
for whichParam = 1:length(orderParams)
    %these csvs have column labels, which are super useful but also a pain
    %when reading them in matlab. Hence skipping the first row.
    %cols: expnum | naive mean | naive radius | model mean | model radius
    data = csvread(strcat(orderParams{whichParam}, 'MeansRadii.csv'), 1, 0);
    
    %determines how the means and their errors are laid out on the x-axis
    spacing = 5;
    max = 9*spacing;
    x1 = 2:spacing:max-1;
    x2 = 1:spacing:max-2;
    handle = figure;
   
    
    naiveMean = data(:, 2);
    naiveRadius = data(:, 3);
    hold on
    errorbar(x1, naiveMean, naiveRadius*10, 'c', 'LineStyle', 'none')
    plot(x1, naiveMean, 'b', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')
    
    %plot(x1, lowBound, 'c', x1, highBound ,'c', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')
    
    modelMean = data(:, 4);
    modelRadius = data(:, 5);
    errorbar(x2, modelMean, modelRadius*10, 'm', 'LineStyle', 'none')
    plot(x2, modelMean, 'r', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')
    
    %plot(x2, lowBound, 'm', x2, highBound ,'m', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')
    
    set(gca,'XTick',spacing/2:spacing:max-spacing/2, 'XTickLabels', 1:9);
    %axis([0 max 0 .0035])
    hold off
    
    write_fig_300_dpi(handle, strcat(orderParams{whichParam}, 'ConfidencePlotCombined'), [7 6]);
    
end