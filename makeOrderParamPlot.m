function makeOrderParamPlot(data1, plotName)
    han = figure;
    plot(data1);
    ylim([0 1])
    saveas(han, plotName);
end