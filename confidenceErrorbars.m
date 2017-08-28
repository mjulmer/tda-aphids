data = load('ConfidenceRadiiMeans.csv');
spacing = 5;
max = 9*spacing;
x1 = 2:spacing:max-1;
x2 = 1:spacing:max-2;
handle = figure;

%naive
mean = data(:, 1);
radius = data(:, 2);
hold on
errorbar(x1, mean, radius, 'c', 'LineStyle', 'none')
plot(x1, mean, 'b', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

%plot(x1, lowBound, 'c', x1, highBound ,'c', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

%interactive
mean = data(:, 3);
radius = data(:, 4);
errorbar(x2, mean, radius, 'm', 'LineStyle', 'none')
plot(x2, mean, 'r', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

%plot(x2, lowBound, 'm', x2, highBound ,'m', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

set(gca,'XTick',spacing/2:spacing:max-spacing/2, 'XTickLabels', 1:9);
axis([0 max 0 .0035])
hold off

write_fig_300_dpi(handle, 'confidencePlotCombined', [7 6]);