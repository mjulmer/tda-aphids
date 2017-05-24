data = [1 2 2 1 1 1 1 1; 2 2 2 1 2 2 2 2; 3 3 3 3 2 3 3 2; 3 4 4 5 4 4 3 3; 4 5 5 5 5 5 4 4; 6 6 6 6 6 6 6 6];
data = flipud(data);

y = 1:6;
x = 1:8;

%so the deal is that you don't have any blocks with value 6,
%so you don't want the b=6 contour and you want to color all
%the other appropriately
%also, the color map is the opposite to the way you would expect it
%to be - it counts from the bottom, i.e. the purple entry is 1 in the 
%matrix, etc.

handle = figure;
hold on;
% cmap = flipud(hsv(6))
% cmap(1, :) = cmap(2,:)
% cmap(2, :) = cmap(4,:)
% cmap(3, :) = cmap(5,:)
% %setting contour 5 to orange, 6 too so the color key doesn't look weird
% cmap(4, :) = [255,69,0]./255
% cmap(5, :) = [255,69,0]./255

cmap = zeros(4 , 3);
%cmap(1, :) = [136, 51, 206]./255;
cmap(1, :) = [51, 61, 204]./255;
cmap(2, :) = [27, 198, 96]./255;
cmap(3, :) = [244, 241, 31]./255;
cmap(4, :) = [249, 168, 37]./255;
%cmap(6, :) = [249, 58, 36]./255;

colormap(handle, cmap)
set(gca,'FontName','Times New Roman','FontSize',10);

contours = [2, 3, 4, 5];
[C, h] = contour(x, y, data, contours, 'ShowText', 'on');
clabel(C, h, 'FontName','Times New Roman','FontSize',10)

box on;
xlabel('Time \it{t}');
ylabel('Proximity parameter \epsilon');
set(gca,'YTick',.5:1:6)
yticklabels(0:0.1:0.5);
colorbar('Ticks',[2.375, 3.125, 3.875, 4.625],'YTickLabel', {'2', '3', '4', '5'})
%saveas(handle, 'toyCROCKER', 'png');
%saveas(handle, 'toyCROCKER');
write_fig_300_dpi(handle, 'Fig4');



