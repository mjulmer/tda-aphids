%takes one run - experimental or simulated - grabs and returns order params
function [group_polarization] = orderParams(data, simulation_flag)
%function [global_polarization, group_polarization] = orderParams(data)
    %Derived from code written by Devin Bjellan (@dbjellan), summer 2015.
    %Computes the order parameters as found in equation 1 (pg 2) of
    %"Topological Data Analysis of Biological Aggregation Models", (Topaz,
    %Ziegelmeier, Halverson.) Over-explicated for the sake of easy reading. 

    %Data is now in order: "frame","x.pos","y.pos","speed","x.dir","y.dir"
    %where each row is an aphid, frame is the current time step, x and y
    %position and direction, speed as you would expect. 
    
    %If the data is simulated, the order is instead exp_num, aphid,
    %aphid_num, frame_num, x.pos, y.pos. 
    
    if simulation_flag == 0
        group_polarization = expDataLoop(data);
    else
        group_polarization = simDataLoop(data);
    end

end

%run this on the simulated data to generate data as you go
function group_polarization = simDataLoop(data)
    %The first column of data is the number of frames: get all of the first
    %column and find the largest number in it to get the last frame.
    end_frame = max(data(:, 2));

    %initialising useful matrices to put things in
    group_polarization = zeros(1, end_frame);
    
    %get the first frame
    index = (data(:, 2) == 1); 
    frame_one = data(index, :);
    
    prev_frame = frame_one;
    
    %the data always starts at frame two, so we do too.
    for frame = 2:end_frame
        %gets the indices of all aphids from a certain frame and grabs that chunk of data. 
        index = (data(:, 2)== frame);
        current_frame = data(index, :);
        num_aphids = size(current_frame, 1);
        %x_positions = current_frame(:, 3);
        %y_positions = current_frame(:, 4);
        %speeds = current_frame(:, 4);
        %x_directions = current_frame(:, 5);
        %y_directions = current_frame(:, 6);
        %so this is the velocity of every aphid in the chunk/timeframe in
        %one large vector
        %so there is a slot in velocities for every possible aphid, but we only
        %divide by the number of aphids which actually occur in the frame.
        velocities = zeros(num_aphids, 2);
        %normalized_velocities = zeros(num_aphids, 1);
        velocities = [current_frame(:, 3)- prev_frame(:, 3), current_frame(:, 4)- prev_frame(:, 4)]; 
        for i = 1:num_aphids
            %velocities(i, :) = [x_positions(i)- prev_frame(i, 3), y_positions(i)- prev_frame(i, 4)]; 
            normalized_velocities(i) = norm(velocities(i, :));
        end
        
%         normalized_velocities = zeros(max_aphid, 1);
%         for i = 1:max_aphid
%             normalized_velocities(i) = norm(velocities(i, :));
%         end
        
        prev_frame = current_frame;
        %keyboard
        %for each frame, save the parameters
        if sum(normalized_velocities) == 0
            group_polarization(frame) = 0;
        else
            group_polarization(frame) = norm(sum(velocities)/sum(normalized_velocities));
        %global_polarization(frame) = v_naught*sum(velocities)/num_aphids;
        end
    end
end


function group_polarization = expDataLoop(data)
    %The first column of data is the number of frames: get all of the first
    %column and find the largest number in it to get the last frame.
    end_frame = max(data(:, 1));

    %initialising useful matrices to put things in
    group_polarization = zeros(1, end_frame);
    
    %the data always starts at frame two, so we do too.
    for frame = 2:end_frame
        %gets the indices of all aphids from a certain frame and grabs that chunk of data. 
        index = (data(:, 1)== frame);
        current_frame = data(index, :);
        num_aphids = size(current_frame, 1);
        speeds = current_frame(:, 4);
        x_directions = current_frame(:, 5);
        y_directions = current_frame(:, 6);
        %so this is the velocity of every aphid in the chunk/timeframe in one large vector
        velocities = [speeds .* x_directions, speeds .* y_directions];
        
        for i = 1:num_aphids
            normalized_velocities(i) = norm(velocities(i, :));
        end
        
        %for each frame, save the parameters
        group_polarization(frame) = norm(sum(velocities)/sum(normalized_velocities));

    end
end

