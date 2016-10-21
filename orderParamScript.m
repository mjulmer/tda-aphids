% Comment through line 9 after the first run so you don't load the data in
% every time.
% expnum = 1;
% aphiddata = load('aphiddata.csv');
% index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
% expData = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
% % For experimental data: [3 4 5 6 7 8] = "frame","x.pos","y.pos","speed","x.dir","y.dir"
% % For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
%  modelData = load(strcat('fullModelDataExp', num2str(expnum), '.csv'));
%  naiveData = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));

total_runs = 10;

comparisonValues = zeros(total_runs, 2);
exp_polar = orderParams(expData, 0);

for runnum = 1:total_runs
    run_index = (modelData(:, 1) == runnum);
    current_run_model = modelData(run_index, [2 3 4 5]);
    run_index = (naiveData(:, 1) == runnum);
    current_run_naive = naiveData(run_index, [2 3 4 5]);

    model_polar = orderParams(current_run_model, 1);
    naive_polar =  orderParams(current_run_naive, 1);

    expModelProduct = findInnerProduct(exp_polar, model_polar);
    expNaiveProduct = findInnerProduct(exp_polar, naive_polar);

    comparisonValues(runnum, :) = [expModelProduct, expNaiveProduct];
end

hist1 = histogram(comparisonValues(:, 1));
hold on
hist2 = histogram(comparisonValues(:, 2));