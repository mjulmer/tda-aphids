% plotAphidTracks.m shows the movment of aphids over time by plotting their
% 'trails'. If you’re using same dataset you can comment that out once it’s in memory.

%it used to account for aphids that appeared in later frames, but could not
%plot their trails, and had to plot the aphids at their first appearance
%rather than their last. This version tracks only the aphids appearing in
%the first frame.

aphiddata = load('aphiddata.csv');
handle = figure;

expnum = 9;
framenum = 2; %starting frame, goes out numOfFrames frames from here
numOfFrames = 900;

% grabs the [frame number, x coord, y coord] of designated 
% experiment and frame
indx = (aphiddata(:,1) == expnum);
expAllFrames = aphiddata(indx, [2, 3, 4, 5]);
indxFrame = ((expAllFrames(:,2) >= framenum) & (expAllFrames(:,2) <= framenum + numOfFrames));
relevantFrames = (expAllFrames(indxFrame, :)); %column 1 aphid number, 2 is frame num, 3 and 4 are x and y coords

%csvwrite(strcat('exp9dataFromFrameSelection', '.csv'), relevantFrames);

%framenum = 3; %the first frame in the experimental data is numbered 2
indx2 = ( relevantFrames(:,2) == framenum);
initFrame = relevantFrames(indx2, [1, 2, 3, 4]);
dims = size(initFrame());
numAphids = dims(1); %the number of aphids in the starting frame, disregarding numbering
aphidIndices = initFrame(:, 1); %a vector containing the aphid numbers for ease of extraction

coordinateMatrix = zeros(numOfFrames, max(aphidIndices), 2); % number of frames * all aphid numbers (plus omitted numbers) * x and y coordinates

for i = 1:numOfFrames %going through each frame
    indxFrame = (relevantFrames(:,2) == framenum + i - 1);
    frameOnly = relevantFrames(indxFrame, [1, 3, 4]);
    elementsInFrame = numel(frameOnly(:,1));
    
    for j = transpose(aphidIndices) % going through all elements in each frame
        aphidPresent = (frameOnly(:,1) == j);
        index = find(aphidPresent); %pulls out the index of the non-zero entry - i.e., where that numbered aphid is
        if ~isempty(index)
            coordinateMatrix(i, frameOnly(index, 1), 1) = frameOnly(index, 2);
            coordinateMatrix(i, frameOnly(index, 1), 2) = frameOnly(index, 3);
        end
    end
end

%csvwrite(strcat('exp9dataFromFrameSelection', '.csv'), relevantFrames);

%keeps track of the first time each element shows up, then plots all of those coordinates
% firstOccurenceEachAphid = zeros(numAphids, 3);
% for i = 1:numAphids
%     firstFrameAppears = find(coordinateMatrix(:, i, 1));
%     if ~isempty(firstFrameAppears)
%         firstOccurenceEachAphid(i, :) = [i, coordinateMatrix(firstFrameAppears(1),i, 1), coordinateMatrix(firstFrameAppears(1), i, 2)];
%     end   
% end
%initFrame = initFrame(any(initFrame,2),:); %deletes all zero aphids (which appear because there is a matrix entry for numbers not corresponding to existing aphids)
initFrame(all(initFrame == 0, 2), :) = [];
 % csvwrite(strcat('firstOccurencesTable', '.csv'), firstOccurenceEachAphid);

lastOccurenceEachAphid = zeros(max(aphidIndices), 3); %will be some 0 entries if the aphids aren't consecutively numbered, but makes the next code block more readable
for i = transpose(aphidIndices)
    lastFrameAppears = find(coordinateMatrix(:, i, 1), 1, 'last'); %get the last index instead of the first
    if ~isempty(lastFrameAppears)
        lastOccurenceEachAphid(i, :) = [i, coordinateMatrix(lastFrameAppears(1),i, 1), coordinateMatrix(lastFrameAppears(1), i, 2)];
    end   
end
% plots current frame
figure
axis([-.25 .25 -.25 .25]);
axis off
pbaspect([1 1 1])

hold on;
%color = [16 145 14];
lastOccurenceEachAphid(all(lastOccurenceEachAphid == 0, 2), :) = []; %deletes all zero aphids (which appear because there is a matrix entry for numbers not corresponding to existing aphids)
scatter(initFrame(:, 3), initFrame(:, 4), 50, [.1 .8 .1], 'filled');
scatter(lastOccurenceEachAphid(:, 2), lastOccurenceEachAphid(:, 3), 'red', 'filled');

rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])


 %drawing lines between appropriate points
 for x = 1:numAphids
     singleAphid = coordinateMatrix(:, x, :);
     positions = find(coordinateMatrix(:, x, 1));
     if size(positions) >= 1
         for y = 1:(size(positions) - 1)
             if coordinateMatrix(y, x, 1) ~= 0
                line([coordinateMatrix(y, x, 1) coordinateMatrix(y + 1, x, 1)'],[coordinateMatrix(y, x, 2) coordinateMatrix(y + 1, x, 2)'],'Marker','.','LineStyle','-', 'LineWidth', 2, 'Color', 'b')
             end
         end
     end
 end
 
 hold off;
 write_fig_300_dpi(handle, 'Fig2', [7.5*.9 7.5*.9]);