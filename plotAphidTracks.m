%
% plotAphidTracks.m does exactly what it says on the tin. REMEMBER TO UNCOMMENT YOUR DATASET FOR THE FIRST RUN.
% If you�re using same dataset you can comment that out once it�s in memory.
% if it�s huge you don�t want to load it every time. So uncomment/type in the dataset you wanna pull from
% (it should be actual aphid position data) set the experiment number (aka video number, for the extended
% simulations this is usually run number and not exp number at all. (that is, it should go up to 100 for the
% 100 run simulations)) Also set the frame you want to start from - remember you have to start from frame 2 if
% you�re using the actual experimental data, because those don�t have a first frame. Check your axes are the
% right dimensions (or wing it, that�s fine too -) and you�re good to go.
%
% If it�s not working, your expnum is probably set to an experiment that doesn�t turn up in the data you selected.
% Look at your data to be sure. Or, it�s possible your axes are wrong for the size of the data. Almost all of the stuff
% I generated or have been playing with is 20cm, so you want the axis([-.3 .3 -.3 .3]); but some might need the bigger
% axes or it may be auto-configured to something zoomed on a smaller region.
% %

%aphiddata = load('aphiddata.csv');
%aphiddata = load('aphiddata.csv');
%aphiddata = load('fullModelDataExp4.csv');
%%aphiddata = load('fullNoInteractionDataExp4.csv');
%aphiddata = load('noInteractionData.csv');
%aphiddata = load('fullNoInteractionDataRun.csv');

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

% theta = linspace(0,2*pi,1000);
% circle = .2*exp(1i*theta);

rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
axis([-.25 .25 -.25 .25]);
axis off
pbaspect([1 1 1])


% hold on; plot(circle,'b-'); hold off;

% and add text labels
% for j = 1:numel(firstOccurenceEachAphid(:, 1))
%     text(firstOccurenceEachAphid(j, 2), firstOccurenceEachAphid(j, 3), strcat( ' - ', int2str(firstOccurenceEachAphid(j, 1))));
% end

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