data = [1 2 2 1 1 1 1 1; 2 2 2 1 2 2 2 2; 3 3 3 3 2 3 3 2; 3 4 4 5 4 4 3 3; 4 5 5 5 5 5 4 4; 6 6 6 6 6 6 6 6];
%http://stackoverflow.com/questions/3942892/how-do-i-visualize-a-matrix-with-colors-and-values-displayed
fig = figure;

handle1 = subplot(2, 1, 1);
imagesc(data);   

% purple 136, 51, 206
% blue 51, 61, 204
% green 27, 198, 96
% yellow 244, 241, 31
% orange 249, 168, 37
% red 249, 58, 36

cmap = zeros(6 , 3);
cmap(1, :) = [136, 51, 206]./255;
cmap(2, :) = [51, 61, 204]./255;
cmap(3, :) = [27, 198, 96]./255;
cmap(4, :) = [244, 241, 31]./255;
cmap(5, :) = [249, 168, 37]./255;
cmap(6, :) = [249, 58, 36]./255;

colormap(cmap)
colorbar('Ticks',[1.416, 2.25, 3.083, 3.917, 4.75, 5.583],'YTickLabel', {'1', '2', '3', '4', '5', '6'})
set(gca,'FontName','Times New Roman','FontSize',10);


textStrings = num2str(data(:),'%i');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x, y] = meshgrid(1:8, 1:6); 
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center', 'FontName','Times New Roman','FontSize',10); %# Plot the strings
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range

%set(gca,'XTick',1:8, 'YTick',0.1:0.1:0.6, 'TickLength',[0 0]);
xlabel('Time \it{t}');
xticklabels([0:1:7]);
ylabel('Proximity parameter \epsilon');
yticklabels(fliplr([0:0.1:0.5]));
title('(A)')

data = flipud(data);

handle2 = subplot(2, 1, 2);
%p is of form [left, bottom, width, height]
p = get(handle2, 'pos');
p(2) = p(2) - .01;
set(handle2, 'pos', p);

y = 1:6;
x = 0:7;

%so the deal is that you don't have any blocks with value 6,
%so you don't want the b=6 contour and you want to color all
%the other appropriately
%also, the color map is the opposite to the way you would expect it
%to be - it counts from the bottom, i.e. the purple entry is 1 in the 
%matrix, etc.

%redefining colormap since it has one fewer color than the above
cmap = zeros(4 , 3);
%cmap(1, :) = [136, 51, 206]./255;
cmap(1, :) = [51, 61, 204]./255;
cmap(2, :) = [27, 198, 96]./255;
cmap(3, :) = [244, 241, 31]./255;
cmap(4, :) = [249, 168, 37]./255;
cmap(5, :) = [249, 58, 36]./255;

colormap(handle2, cmap)


contours = [2, 3, 4, 5, 6];
[C, h] = contour(x, y, data, contours, 'ShowText', 'on');
clabel(C, h, 'FontName','Times New Roman','FontSize',10)
axis([0 7 0 6])
box on;
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
set(gca,'YTick',0:1.2:6);
%yticklabels(0:0.1:0.5);
yticklabels(0:0.1:0.5);
set(gca,'XTick',0:1:8)
xticklabels(0:1:7);
colorbar('Ticks',[2.4, 3.2, 4, 4.8, 5.6],'YTickLabel', {'2', '3', '4', '5', '6'})
set(gca,'FontName','Times New Roman','FontSize',10);
title('(B)')



write_fig_300_dpi(fig, 'Fig4');
