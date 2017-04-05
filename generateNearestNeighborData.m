
for expnum = 5:9
    % For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
    data = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
    %data = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));
    
    total_runs = 100;
    
    for runnum = 1:total_runs
        run_index = (data(:, 1) == runnum);
        current_run = data(run_index, [2 3 4 5]);
        
        %The first column of data is the number of frames: get all of the first
        %column and find the largest number in it to get the last frame.
        end_frame = max(current_run(:, 2));
        
        %initialising useful matrices to put things in
        mean_distance = zeros(1, end_frame);
        
        %get the first frame
        index = (current_run(:, 2) == 1);
        frame_one = current_run(index, :);
        num_aphids = size(frame_one, 1);
        prev_frame = frame_one;
        
        %the data always starts at frame two, so we do too.
        for frame = 2:end_frame
            %gets the indices of all aphids from a certain frame and grabs that chunk of data.
            index = (current_run(:, 2)== frame);
            current_frame = current_run(index, :);
          
            %closest neighbor for each aphid
            closest_neighbor = zeros(1, num_aphids);
            for i = 1:num_aphids
                %distances of all other aphids
                distances = zeros(1, num_aphids);
                x1 = current_frame(i, 3);
                y1 = current_frame(i, 4);
                for j = 1:num_aphids
                    if i ~= j
                        x2 = current_frame(j, 3);
                        y2 = current_frame(j, 4);
                        distances(j) = pointDistance(x1, y1, x2, y2);
                    end
                end
                %this technically only detects the nearest aphid which
                %is not 0 away, but eh, that's okay
                closest_neighbor(i) = min(distances(distances > 0));
            end
            mean_distance(frame) = mean(closest_neighbor);
        end
        %name = strcat('nearNeighborPlotExp', num2str(expnum), 'run', num2str(runnum), '.png');
        %makeOrderParamPlot(mean_distance, name); 
        name = strcat('nearNeighborModelExp', num2str(expnum), 'run', num2str(runnum), '.csv');
        csvwrite(name, mean_distance);
        runnum
    end
    exp_done = expnum %print statement for progress
end
