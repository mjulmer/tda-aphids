%takes one run - experimental or simulated - grabs and returns order params
function [group_polarization, angular_momentum, absolute_ang_momentum] = orderParams(data, simulation_flag)
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
        [group_polarization, angular_momentum, absolute_ang_momentum] = expDataLoop(data);
    else
        [group_polarization, angular_momentum, absolute_ang_momentum] = simDataLoop(data);
    end

end

%run this on the simulated data to generate data as you go
function [group_polarization, angular_momentum, absolute_ang_momentum] = simDataLoop(data)
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
        velocity_vector_length = 2; %no magic numbers
        %normalized_velocities = zeros(num_aphids, 1);
        velocities = [current_frame(:, 3)- prev_frame(:, 3), current_frame(:, 4)- prev_frame(:, 4)]; 
        
        normalized_velocities = zeros(velocity_vector_length, 1);
        normalized_rel_positions = zeros(velocity_vector_length, 1);
        cross_relpos_velocities = zeros(velocity_vector_length, 1);
 
        position_vectors = current_frame(:, [3 4]);
        center_of_mass = sum(position_vectors)/num_aphids;
        %make an array for easy subtraction of CoM from relative positoins
        mass_array = repmat(center_of_mass, num_aphids, 1);
        relative_positions = position_vectors - mass_array;

        
        for i = 1:num_aphids
            %velocities(i, :) = [x_positions(i)- prev_frame(i, 3), y_positions(i)- prev_frame(i, 4)]; 
            normalized_velocities(i) = norm(velocities(i, :));
            normalized_rel_positions(i) = norm(relative_positions(i, :));
            %cross product of relative positon and velocity
            cross_relpos_velocities(i) = relative_positions(i, 1)*velocities(i, 2) - relative_positions(i, 2)*velocities(i, 1);
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
        end
        
        product_norms = normalized_rel_positions.*normalized_velocities;
        if sum(product_norms) == 0
            angular_momentum(frame) = 0;
            absolute_ang_momentum(frame) = 0;
        else
            angular_momentum(frame) = norm(sum(cross_relpos_velocities)/sum(product_norms));
            absolute_ang_momentum(frame) = norm(sum(norm(cross_relpos_velocities))/sum(product_norms));
        end
    end
end


function [group_polarization, angular_momentum, absolute_ang_momentum] = expDataLoop(data)
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
        velocity_vector_length = 2; %no magic numbers

        normalized_velocities = zeros(velocity_vector_length, 1);
        normalized_rel_positions = zeros(velocity_vector_length, 1);
        cross_relpos_velocities = zeros(velocity_vector_length, 1);

        position_vectors = current_frame(:, [2 3]);
        center_of_mass = sum(position_vectors)/num_aphids;
        %make an array for easy subtraction of CoM from relative positoins
        mass_array = repmat(center_of_mass, num_aphids, 1);
        relative_positions = position_vectors - mass_array;
        
        for i = 1:num_aphids
            normalized_velocities(i) = norm(velocities(i, :));
            normalized_rel_positions(i) = norm(relative_positions(i, :));
            %cross product of relative positon and velocity
            cross_relpos_velocities(i) = relative_positions(i, 1)*velocities(i, 2) - relative_positions(i, 2)*velocities(i, 1);
        end
        
%         %for each frame, save the parameters
%         group_polarization(frame) = norm(sum(velocities)/sum(normalized_velocities));
%         
%         product_norms = normalized_rel_positions.*normalized_velocities;
%         angular_momentum(frame) = norm(sum(cross_relpos_velocities)/sum(product_norms));
%         absolute_ang_momentum(frame) = norm(sum(norm(cross_relpos_velocities))/sum(product_norms));
            %for each frame, save the parameters
        if sum(normalized_velocities) == 0
            group_polarization(frame) = 0;
        else
            group_polarization(frame) = norm(sum(velocities)/sum(normalized_velocities));
        end
        
        product_norms = normalized_rel_positions.*normalized_velocities;
        if sum(product_norms) == 0
            angular_momentum(frame) = 0;
            absolute_ang_momentum(frame) = 0;
        else
            angular_momentum(frame) = norm(sum(cross_relpos_velocities)/sum(product_norms));
            absolute_ang_momentum(frame) = norm(sum(norm(cross_relpos_velocities))/sum(product_norms));
        end

    end
end

