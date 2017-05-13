% plotAphidTracks.m shows the movment of aphids over time by plotting their
% 'trails'. If you�re using same dataset you can comment that out once it�s in memory.

%aphiddata = load('aphiddata.csv');

expnum = 1;
framenum = 2; %starting frame, goes out numOfFrames frames from here
numOfFrames = 300;
stepsize = 0.001;
epsilon = stepsize;
maximum = 0.05;

% grabs the [frame number, x coord, y coord] of designated 
% experiment and frame
indx = (aphiddata(:,1) == expnum);
sim1fxy = aphiddata(indx, [2, 3, 4, 5]);
indxFrame = ((sim1fxy(:,2) >= framenum) & (sim1fxy(:,2) <= framenum + numOfFrames));

relevantFrames = (sim1fxy(indxFrame, [1, 3, 4]));
maxAphidNum = max(relevantFrames(:,1));
coordinateMatrix = zeros(numOfFrames, maxAphidNum, 2); % number of frames * all aphid numbers * x and y coordinates

for i = 1:numOfFrames %going through each frame
    indxFrame = (sim1fxy(:,2) == framenum + i - 1);
    frameOnly = sim1fxy(indxFrame, [1, 3, 4]);
    elementsInFrame = numel(frameOnly(:,1));
    
    for j = 1:elementsInFrame % going through all elements in each frame
        coordinateMatrix(i, frameOnly(j, 1), 1) = frameOnly(j, 2);
        coordinateMatrix(i, frameOnly(j, 1), 2) = frameOnly(j, 3);
    end
end

%keeps track of the first time each element shows up, then plots all of those coordinates
firstOccurenceEachAphid = zeros(maxAphidNum, 3);
for i = 1:maxAphidNum
    firstFrameAppears = find(coordinateMatrix(:, i, 1));
    if ~isempty(firstFrameAppears)
        firstOccurenceEachAphid(i, :) = [i, coordinateMatrix(firstFrameAppears(1),i, 1), coordinateMatrix(firstFrameAppears(1), i, 2)];
    end   
end
firstOccurenceEachAphid = firstOccurenceEachAphid(any(firstOccurenceEachAphid,2),:); %deletes all zero lines

% plots current frame
figure
scatter(firstOccurenceEachAphid(:, 2), firstOccurenceEachAphid(:, 3), 'filled'); %TODO: this will not account for points that show up in later frames but not in this one!

rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
axis([-.25 .25 -.25 .25]);
axis off
pbaspect([1 1 1])

 %drawing lines between appropriate points
 for x = 1:maxAphidNum
     singleAphid = coordinateMatrix(:, x, :);
     positions = find(coordinateMatrix(:, x, 1));
     if size(positions) >= 1
         for y = 1:(size(positions) - 1)
             if coordinateMatrix(y, x, 1) ~= 0
                line([coordinateMatrix(y, x, 1) coordinateMatrix(y + 1, x, 1)'],[coordinateMatrix(y, x, 2) coordinateMatrix(y + 1, x, 2)'],'Marker','.','LineStyle','-', 'LineWidth', 2, 'Color', 'r')
             end
         end
     end
 end
 
 write_fig_300_dpi(handle, 'Fig2');