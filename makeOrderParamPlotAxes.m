function makeOrderParamPlotAxes(data1, plotName, yMax)
    han = figure;
    %plot(data1, 'LineWidth',2);
    plot(data1);
    ylim([0 yMax])
    saveas(han, plotName);
end