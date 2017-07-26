expnum1 = 5;
expnum2 = 7;
%data1 = load(strcat('full100modelAverageExp', num2str(expnum1), '.csv'));
%data2 = load(strcat('full100modelAverageExp', num2str(expnum2), '.csv'));
%data3 = load(strcat('full100noInteractionAverageExp', num2str(expnum1), '.csv'));
%data4 = load(strcat('full100noInteractionAverageExp', num2str(expnum2), '.csv'));

frameNums = [4605; 5647; 5651; 5409; 5409; 5221; 5332; 5418; 5883];

%manually defining a colormap
cmap = zeros(11, 3);
%cmap(2, :) = [252, 22, 133]./255;
cmap(1, :) = [233, 22, 252]./255;%should not be seen or used
cmap(2, :) = [160, 22, 252]./255;%purple
cmap(3, :) = [22, 41, 252]./255; %blue
%cmap(5, :) = [22, 244, 252]./255; %original teal
cmap(4, :) = [22, 225, 252]./255; %teal1
cmap(5, :) = [22, 252, 117]./255; %teal2 [more green]
cmap(6, :) = [148, 252, 22]./255; %green
cmap(7, :) = [252, 252, 22]./255; %yellow
cmap(8, :) = [252, 145, 22]./255; %orange
cmap(9, :) = [252, 34, 22]./255; %red
cmap(10, :) = [252, 22, 133]./255;
cmap(11, :) = [233, 22, 252]./255;

maxfilt = 0.2;
filtrationgap = .00005;
filtrationtimes = 0:filtrationgap:maxfilt;
timesamples = 1000;
endframe1 = frameNums(expnum1);
endframe2 = frameNums(expnum2);

numContours = 10;
cbarMin = 1.8;
cbarMax = 10;
ticks = zeros(1, numContours);
for n = 1:numContours
    %for each: the point at which the color bar starts (here, 1)
    %plus the distance to the first tick (half the distance at which the ticks are spread)
    %plus the distance the ticks are spread, multiplied by the number of ticks
    %obv this could be simplified but this is conceptually clearer and
    %the compiler will take care of it
    tickSpacing = (cbarMax - cbarMin)/ numContours;
    ticks(1, n) =  1.8 + 0.5*tickSpacing + (n - 1)*tickSpacing;
end
tickLabels = transpose(2:numContours+1);

% make our contour plot with provided contours
y = 0:filtrationgap:maxfilt;
x = 1:timesamples;
for i = 1:timesamples
    x(1, i) = sampletoframe(i, timesamples, endframe1);
end
x = .5 * x;
contours = 1:numContours;

handle = figure;

handle1 = subplot(4, 1, 1);
%p is of form [left, bottom, width, height]
p = get(handle1, 'pos');
p(2) = p(2) + .04;
set(handle1, 'pos', p);

[C, h] = contour(x, y, data1, contours);
h.ZData; %for testing
%clabel(C, h, 'FontName','Times New Roman','FontSize',10)
%[C, h] = contourf(x, y, data, contours);
set(gca,'FontName','Times New Roman','FontSize',10);
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
colormap(handle1, cmap); % or default, hsv
%contourcmap(cmap)
%colorbar; set(h, 'ylim', [100 150])
colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels), 'ylim', [cbarMin cbarMax])
title('(A)')
%colorbar('ylim', [1.8 10])


handle2 = subplot(4, 1, 2);
%p is of form [left, bottom, width, height]
p = get(handle2, 'pos');
p(2) = p(2) + .01;
set(handle2, 'pos', p);

%redefine x range since new number for last frame
x = 1:timesamples;
for i = 1:timesamples
    x(1, i) = sampletoframe(i, timesamples, endframe2);
end
x = .5 * x;

[C, h] = contour(x, y, data2, contours);
set(gca,'FontName','Times New Roman','FontSize',10);
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
colormap(handle2, cmap); %hsv; % or default
%colorbar;
%colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels))
colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels), 'ylim', [cbarMin cbarMax])
title('(B)')


handle3 = subplot(4, 1, 3);
%p is of form [left, bottom, width, height]
p = get(handle3, 'pos');
p(2) = p(2) - .02;
set(handle3, 'pos', p);

%redefine x range since new number for last frame
x = 1:timesamples;
for i = 1:timesamples
    x(1, i) = sampletoframe(i, timesamples, endframe1);
end
x = .5 * x;

[C, h] = contour(x, y, data3, contours);
set(gca,'FontName','Times New Roman','FontSize',10);
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
colormap(handle3, cmap); %hsv; % or default
%colorbar;
%colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels))
colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels), 'ylim', [cbarMin cbarMax])
title('(C)')



handle4 = subplot(4, 1, 4);
%p is of form [left, bottom, width, height]
p = get(handle4, 'pos');
p(2) = p(2) - .05;
set(handle4, 'pos', p);

%redefine x range since new number for last frame
x = 1:timesamples;
for i = 1:timesamples
    x(1, i) = sampletoframe(i, timesamples, endframe2);
end
x = .5 * x;

[C, h] = contour(x, y, data4, contours);
set(gca,'FontName','Times New Roman','FontSize',10);
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
colormap(handle4, cmap); %hsv; % or default
%colorbar;
%colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels))
colorbar('Ticks', ticks, 'YTickLabel', num2str(tickLabels), 'ylim', [cbarMin cbarMax])
title('(D)')

%saveas(han, strcat('playCROCKERexp', num2str(expnum)));
%saveas(han, strcat('noInteraction100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum)), 'png');


write_fig_300_dpi(handle, 'Fig6', [7 8.5*.95]);
