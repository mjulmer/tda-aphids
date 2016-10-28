% Comment through line 9 after the first run so you don't load the data in
% every time.
expnum = 1;
aphiddata = load('aphiddata.csv');
index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
expData = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
% For experimental data: [3 4 5 6 7 8] = "frame","x.pos","y.pos","speed","x.dir","y.dir"
% For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
modelData = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
naiveData = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));

total_runs = 100;

comparisonValues = zeros(total_runs, 2);
[exp_polar, exp_ang, exp_abs] = orderParams(expData, 0);

for runnum = 1:total_runs
    run_index = (modelData(:, 1) == runnum);
    current_run_model = modelData(run_index, [2 3 4 5]);
    run_index = (naiveData(:, 1) == runnum);
    current_run_naive = naiveData(run_index, [2 3 4 5]);

    [model_polar, model_ang, model_abs] = orderParams(current_run_model, 1);
    [naive_polar, naive_ang, naive_abs] =  orderParams(current_run_naive, 1);

    expModelPolar = findInnerProduct(exp_polar, model_polar);
    expNaivePolar = findInnerProduct(exp_polar, naive_polar);
    
    expModelAng = findInnerProduct(exp_ang, model_ang);
    expNaiveAng = findInnerProduct(exp_ang, naive_ang);
    
    expModelAbs = findInnerProduct(exp_abs, model_abs);
    expNaiveAbs = findInnerProduct(exp_abs, naive_abs);

    comparisonPolar(runnum, :) = [expModelPolar, expNaivePolar];
    comparisonAng(runnum, :) = [expModelAng, expNaiveAng];
    comparisonPolar(runnum, :) = [expModelAbs, expNaiveAbs];
end

polarName = strcat('comparisonPolar', num2str(expnum), '.png');
angName = strcat('comparisonAng', num2str(expnum), '.png');
absName = strcat('comparisonAbs', num2str(expnum), '.png');
makeHistogram(comparisonPolar, plotName);
makeHistogram(comparisonAng, angName);
makeHistogram(comparisonPolar, absName);
