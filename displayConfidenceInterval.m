data = load('frobConfidenceIntervals.csv');
x = 1:9;

handle = figure;
handle1 = subplot(2, 1, 1);

%naive
mean = data(:, 1);
lowBound = data(:, 2);
highBound = data(:, 3);
plot(x, mean, 'b', x, lowBound, 'c', x, highBound ,'c', 'Marker', '.', 'MarkerSize', 10, 'LineStyle', 'none')
axis([0 10 0 .0035])
title('(A)')

handle2 = subplot(2, 1, 2);

%interactive
mean = data(:, 4);
lowBound = data(:, 5);
highBound = data(:, 6);
plot(x, mean, 'r', x, lowBound, 'm', x, highBound ,'m', 'Marker', '.', 'MarkerSize', 10, 'LineStyle', 'none')
axis([0 10 0 .0035])
title('(B)')

write_fig_300_dpi(handle, 'confidencePlot', [7 8.5*.95]);