 for expnum = 1:9
    data = load(strcat('full100noInteractionStandardDevExp', num2str(expnum), '.csv'));
    han = figure;
    a = axes;
    imagesc(data)
    h = colorbar;
    %(a, 'CLim', [0 3.5]);
    %saveas(han, strcat('noInteraction100StandardDevHeatmapExp', num2str(expnum), 'standColorbar'));
 
    saveas(han, strcat('noInteraction100StandardDevHeatmapExp', num2str(expnum)));
end


