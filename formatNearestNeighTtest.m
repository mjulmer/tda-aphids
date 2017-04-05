
%aphiddata = load('aphiddata.csv');
for expnum = 6:8
    if expnum == 4 %because there are NaN's in exp 4 data that screw things up
        continue
    end
    index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    expData = aphiddata(index, [3 11]);  %get relevant columns
    % For experimental data: [3 11] = "frame", "nearest.neighbor"
    
    %generates the averages of the distances to nearest neighbors
    end_frame = max(expData(:, 1));
    exp_neighbors = zeros(1, end_frame);
    for frame = 2:end_frame
        %gets the indices of all aphids from a certain frame and grabs that chunk of data. 
        index = (expData(:, 1)== frame);
        current_frame = expData(index, :);
        numAphids = size(current_frame, 1);
        distNeighbor = current_frame(:, 2);
        if isinf(distNeighbor)
%         if frame == 1960
%             distNeighbor
%             infvalue = isinf(distNeighbor)
%         end
            exp_neighbors(frame) = exp_neighbors(frame - 1);
        else
            exp_neighbors(frame) = sum(distNeighbor)/numAphids;
        end
    end
    csvwrite(strcat('experimentalNearNeighborExp', num2str(expnum), '.csv'), exp_neighbors);
    %keyboard
    %gets average of experimental data with each run of the simulated data
    exp_naive = zeros(1, 100);
    exp_model = zeros(1, 100);
    for runnum = 1:100
        dataNaive = importdata(strcat('nearNeighborPlotExp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        dataModel = importdata(strcat('nearNeighborModelExp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        
        %on exp2, exp_naive has a few infs and then is all 0s. (infs got set, I guess.)
        exp_naive(1, runnum) = norm(dataNaive - exp_neighbors, 2);
        exp_model(1, runnum) = norm(dataModel - exp_neighbors, 2);
    end
    
    csvwrite(strcat('expNearNeighborNaiveExp', num2str(expnum), '.csv'), exp_naive);
    csvwrite(strcat('expNearNeighborModelExp', num2str(expnum), '.csv'), exp_model);
    
    %---and now use that data to put into the combined file for t-test---

    data = zeros(200, 2);
    data(2:101, 1) = transpose(exp_naive);
    data(2:101, 2) = 1;
    data(102:201, 1) = transpose(exp_model);
    data(102:201, 2) = 2;

    csvwrite(strcat('nearNeighbor', 'Exp', num2str(expnum), 'forTtest', '.csv'), data);

end