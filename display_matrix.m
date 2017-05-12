%http://stackoverflow.com/questions/3942892/how-do-i-visualize-a-matrix-with-colors-and-values-displayed
data = [1 2 2 1 1 1 1 1; 2 2 2 1 2 2 2 2; 3 3 3 3 2 3 3 2; 3 4 4 5 4 4 3 3; 4 5 5 5 5 5 4 4; 6 6 6 6 6 6 6 6];
handle = imagesc(data);   
hold on;%# Create a colored plot of the matrix values

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
colorbar



textStrings = num2str(data(:),'%i');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x, y] = meshgrid(1:8, 1:6); 
%x = meshgrid(1:6);
%y = meshgrid(1:8); %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center'); %# Plot the strings
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range

%set(gca,'XTick',1:8, 'YTick',0.1:0.1:0.6, 'TickLength',[0 0]);
xlabel('Time');
ylabel('Filtration parameter');
yticklabels(fliplr([0:0.1:0.5]));
saveas(handle, 'toyMatrix', 'png');
hold off;