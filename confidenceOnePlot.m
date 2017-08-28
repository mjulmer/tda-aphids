data = load('frobConfidenceIntervals.csv');
x = 1:9;

handle = figure;

%naive
mean = data(:, 1);
lowBound = data(:, 2);
highBound = data(:, 3);
hold on
plot(x, mean, 'b', 'Marker', '.', 'MarkerSize', 15)
plot(x, lowBound, 'c', x, highBound ,'c', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

%interactive
mean = data(:, 4);
lowBound = data(:, 5);
highBound = data(:, 6);
plot(x, mean, 'r', 'Marker', '.', 'MarkerSize', 15)
plot(x, lowBound, 'm', x, highBound ,'m', 'Marker', '.', 'MarkerSize', 15, 'LineStyle', 'none')

axis([0 10 0 .0035])
hold off

write_fig_300_dpi(handle, 'confidencePlotCombined', [7 6]);