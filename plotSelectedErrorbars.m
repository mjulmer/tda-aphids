function plotSelectedErrorbars(data, error, name, resolution, yMax)
    h=errorbar(1:resolution:length(data),data(1:resolution:end),error(1:resolution:end));
    %k = get(h,'Children');
    %set(k(1),'Color','w');
    hold on
    plot(data)
    ylim([0 yMax])
    saveas(h, strcat(name, 'ErrorAverage2', '.png'));
    saveas(h, strcat(name, 'ErrorAverage2'));
    hold off
end