% Comment through line 9 after the first run so you don't load the data in
% every time.

aphiddata = load('aphiddata.csv');

for expnum = 2:3
    index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    expData = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
    % For experimental data: [3 4 5 6 7 8] = "frame","x.pos","y.pos","speed","x.dir","y.dir"
    % For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
    modelData = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
    naiveData = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));

    total_runs = 100;

    comparisonValues = zeros(total_runs, 2);
    [exp_polar, exp_ang, exp_abs] = orderParams(expData, 0);
    polarName = strcat('polarPlotExp', num2str(expnum), '.png');
    angName = strcat('angPlotExp', num2str(expnum), '.png');
    absName = strcat('absPlotExp', num2str(expnum), '.png');
    makeOrderParamPlot(exp_polar, polarName);
    makeOrderParamPlot(exp_ang, angName);
    makeOrderParamPlot(exp_abs, absName);
    
    exp_naive_polar = zeros(1, 100);
    exp_naive_ang = zeros(1, 100);
    exp_naive_abs = zeros(1, 100);
    exp_model_polar = zeros(1, 100);
    exp_model_abs = zeros(1, 100);
    exp_model_ang = zeros(1, 100);
    
    for runnum = 1:total_runs
        run_index = (modelData(:, 1) == runnum);
        current_run_model = modelData(run_index, [2 3 4 5]);
        run_index = (naiveData(:, 1) == runnum);
        current_run_naive = naiveData(run_index, [2 3 4 5]);

        [model_polar, model_ang, model_abs] = orderParams(current_run_model, 1);
        [naive_polar, naive_ang, naive_abs] =  orderParams(current_run_naive, 1);
        
        exp_naive_polar(1, runnum) = norm(naive_polar - exp_polar, 2);
        exp_naive_ang(1, runnum) = norm(naive_ang - exp_ang, 2);
        exp_naive_abs(1, runnum) = norm(naive_abs - exp_abs, 2);
        exp_model_polar(1, runnum) = norm(model_polar - exp_polar, 2);
        exp_model_abs(1, runnum) = norm(model_ang - exp_ang, 2);
        exp_model_ang(1, runnum) = norm(model_abs - exp_abs, 2);
    
        polarName = strcat('polarPlotNaive', num2str(expnum), 'run',  num2str(runnum));
        angName = strcat('angPlotNaive', num2str(expnum), 'run',  num2str(runnum));
        absName = strcat('absPlotNaive', num2str(expnum), 'run',  num2str(runnum));
        makeOrderParamPlot(naive_polar, strcat(polarName, '.png'));
        makeOrderParamPlot(naive_ang, strcat(angName, '.png'));
        makeOrderParamPlot(naive_abs, strcat(absName, '.png'));


        polarName = strcat('polarPlotModel', num2str(expnum), 'run',  num2str(runnum));
        angName = strcat('angPlotModel', num2str(expnum), 'run',  num2str(runnum));
        absName = strcat('absPlotModel', num2str(expnum), 'run',  num2str(runnum));
        makeOrderParamPlot(model_polar, strcat(polarName, '.png'));
        makeOrderParamPlot(model_ang, strcat(angName, '.png'));
        makeOrderParamPlot(model_abs, strcat(absName, '.png'));

        close all

    end
    
        csvwrite(strcat('polarPlotNaiveExp', num2str(expnum), '.csv'), exp_naive_polar);
        csvwrite(strcat('angPlotNaiveExp', num2str(expnum), '.csv'), exp_naive_ang);
        csvwrite(strcat('absPlotNaiveExp',  num2str(expnum), '.csv'), exp_naive_abs);
        
        csvwrite(strcat('polarPlotModelExp', num2str(expnum), '.csv'), exp_model_polar);
        csvwrite(strcat('angPlotModelExp', num2str(expnum), '.csv'), exp_model_ang);
        csvwrite(strcat('absPlotModelExp', num2str(expnum), '.csv'), exp_model_abs);
    
    exp_done = expnum %print statement for progress
end
