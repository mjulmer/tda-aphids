% Comment through line 9 after the first run so you don't load the data in
% every time.

%aphiddata = load('aphiddata.csv');

for expnum = 1:9
    index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    expData = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
    % For experimental data: [3 4 5 6 7 8] = "frame","x.pos","y.pos","speed","x.dir","y.dir"
    % For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
    modelData = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
    naiveData = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));

    total_runs = 5;

    comparisonValues = zeros(total_runs, 2);
    [exp_polar, exp_ang, exp_abs] = orderParams(expData, 0);
    polarName = strcat('polarPlotExp', num2str(expnum), '.png');
    angName = strcat('angPlotExp', num2str(expnum), '.png');
    absName = strcat('absPlotExp', num2str(expnum), '.png');
    makeOrderParamPlot(exp_polar, polarName);
    makeOrderParamPlot(exp_ang, angName);
    makeOrderParamPlot(exp_abs, absName);

    for runnum = 1:total_runs
        run_index = (modelData(:, 1) == runnum);
        current_run_model = modelData(run_index, [2 3 4 5]);
        run_index = (naiveData(:, 1) == runnum);
        current_run_naive = naiveData(run_index, [2 3 4 5]);

        [model_polar, model_ang, model_abs] = orderParams(current_run_model, 1);
        [naive_polar, naive_ang, naive_abs] =  orderParams(current_run_naive, 1);
    
        polarName = strcat('polarPlotNaive', num2str(expnum), 'run',  num2str(runnum), '.png');
        angName = strcat('angPlotNaive', num2str(expnum), 'run',  num2str(runnum), '.png');
        absName = strcat('absPlotNaive', num2str(expnum), 'run',  num2str(runnum), '.png');
        makeOrderParamPlot(naive_polar, polarName);
        makeOrderParamPlot(naive_ang, angName);
        makeOrderParamPlot(naive_abs, absName);

        polarName = strcat('polarPlotModel', num2str(expnum), 'run',  num2str(runnum), '.png');
        angName = strcat('angPlotModel', num2str(expnum), 'run',  num2str(runnum), '.png');
        absName = strcat('absPlotModel', num2str(expnum), 'run',  num2str(runnum), '.png');
        makeOrderParamPlot(model_polar, polarName);
        makeOrderParamPlot(model_ang, angName);
        makeOrderParamPlot(model_abs, absName);

    end
    
    exp_done = expnum %print statement for progress
end
