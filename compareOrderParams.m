function comparisonValues = compareOrderParams(x)
    %load_javaplex;
    exp_num = 1;
    data = loadData(exp_num);
    expData = data(1);
    modelData = data(2);
    naiveData = data(3);

     expParams = extractOrderParams(expData);
     modelParams = extractOrderParams(modelData);
     naiveParams =  extractOrderParams(naiveData);
     expModelProduct = findInnerProduct(expParams, modelParams)
     expNaiveProduct = findInnerProduct(expParams, naiveParams)
     
end

%loads data from a run and maybe calls extractOrderParams on it?
function data = loadData(expnum)
    %and something like this for the genuine comparison
    %TODO: implement machinery for loading each exp simulated data; exp data
    %to start probably just to exp 1?
    %load the CSVs of - not crocker plots, just experimental and model data
    %for each of the models. Then use a vectorized approach to 
    
    %expModel = zeroes(1, N);
    %expNaive = zeroes(1, N);
    
    %index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    %data = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
    
    dimension = 0;
    
    expData = load(strcat('experimental', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    
    for runnum = 1:N
        modelData = load(strcat('model100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        naiveData = load(strcat('noInteraction100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        %runnum;
    end
    
    
    %values = diffMatrix12./(sizeSamp(1) * sizeSamp(2));
    %csvwrite(strcat('ModelAndExperimental100', 'h', num2str(dimension), 'exp', num2str(m), 'differences', '.csv'), values)
    
    %values = diffMatrix13./(sizeSamp(1) * sizeSamp(2));
    %csvwrite(strcat('ExperimentalAndNon100', 'h', num2str(dimension), 'exp', num2str(m), 'differences', '.csv'), values)
    
    %expDone = m; %no semicolon to see how many done

    data = [expData, modelData, naiveData];

end


%takes one run - experimental or simulated - grabs and returns order params
function orderParams = extractOrderParams(data)
    %expModel(1, runnum) = innerProduct %reulst of findInnerProduct
    
    %please check to make sure this actually works for all the new
    %generated data - how is it even read in?
    
    %this is for the experimental data.
    %so stick it in a function and then call it for the experimental and
    %each piece of simulated data, throwing out the simulated data when
    %youre done with it.
    %Once you have the data for each: multiply each point together and then
    %sum them all up
    
    
    %devin's code for grabbing order params
    %ASSUME HERE THAT DATA ALREADY IS WHAT YOU WANT
    %index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    %data = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
    data = data([3 4 5 6 7 8]); %no clue if this will work
    endframe = max(data(:, 1));
    %x = 1:endframe;
    totalvel = 0*ones(endframe, 2);
    pol = 0*ones(1, endframe);
    mang = 0*ones(1, endframe);
    mabs = 0*ones(1, endframe);
    for frame = 2:endframe
        index = (data(:, 1)== frame);
        thisframe = data(index, :);
        vel = [thisframe(:, 4) .* thisframe(:, 5), thisframe(:, 4) .* thisframe(:, 6)];
        totalvel(frame, :) = sum(vel)/length(vel);
        velnorm = 0*ones(length(vel), 1);
        mangs1 = 0*ones(length(vel), 1);
        mangs2 = 0*ones(length(vel), 1);
        mabss1 = 0*ones(length(vel), 1);
        for i = 1:size(thisframe, 1)
            velnorm(i) = norm(vel(i, :));
            mabss1(i) = norm(vel(i, 1) * thisframe(i, 3) - vel(i, 2) * thisframe(i, 2));
            mangs1(i) = vel(i, 1) * thisframe(i, 3) - vel(i, 2) * thisframe(i, 2);
            mangs2(i) = norm(thisframe(i, [2 3]))*norm(vel(i, :));
        end
        pol(frame) = norm(sum(vel)/sum(velnorm));
        mang(frame) = norm(sum(mangs1)/sum(mangs2));
        mabs(frame) = norm(sum(mabss1)/sum(mangs2));
    end
    %x = .5 * x;
    
    orderParams = [pol, mang, mabs]; %pol? momentum angular momentum absolute?

%         han = figure;
%         plot(x, pol);
%         xlabel('Time (s)');
%         title(strcat('Polarization vs time for experiment: ', num2str(expnum)));
%         fname = strcat('polarization_exp_', num2str(expnum));
%         saveas(han, char(fname), 'png');

end


%takes two sets of order parameters and takes their inner product
%<f-g, f-g> = integral of (f-g)^2
function innerProduct = findInnerProduct(orderParams1, orderParams2)
    diff = abs(orderParams1 - orderParams2); %so this should now be an array of the same dimensions
    squared = diff.^2;
    innerProduct = sum(squared(:)); %remember to exclude the last endpoint!
end