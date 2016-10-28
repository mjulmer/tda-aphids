function makeHistogram(data, plotName)
    han = figure;
    
    hist1 = histogram(data(:, 1)); %exp model
    hold on
    hist2 = histogram(data(:, 2)); %exp naive

    bin_width = 4;
    hist1.BinWidth = bin_width;
    hist2.BinWidth = bin_width;

    saveas(han, plotName);
end