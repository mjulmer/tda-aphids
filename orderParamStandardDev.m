% Comment out aphiddata after first run so you don't load it every time

%aphiddata = load('aphiddata.csv');
scale = 0.5; %y-axis max for plots

for expnum = 2:3
    index = (aphiddata(:,1) == expnum); %grab only the experiment you want, with all the frames of that run
    expData = aphiddata(index, [3 4 5 6 7 8]);  %get relevant columns
    % For experimental data: [3 4 5 6 7 8] = "frame","x.pos","y.pos","speed","x.dir","y.dir"
    % For simulated data: [2 3 4 5] = "aphid_label" "frame","x.pos","y.pos"
    modelData = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
    naiveData = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));
    
    total_runs = 100;
    
 %   comparisonValues = zeros(total_runs, 2);
 %   [exp_polar, exp_ang, exp_abs] = orderParams(expData, 0);
%     polarName = strcat('polarPlotExp', num2str(expnum), '.png');
%     angName = strcat('angPlotExp', num2str(expnum), '.png');
%     absName = strcat('absPlotExp', num2str(expnum), '.png');
%     makeOrderParamPlot(exp_polar, polarName);
%     makeOrderParamPlot(exp_ang, angName);
%     makeOrderParamPlot(exp_abs, absName);
%     
%     exp_naive_polar = zeros(1, 100);
%     exp_naive_ang = zeros(1, 100);
%     exp_naive_abs = zeros(1, 100);
%     exp_model_polar = zeros(1, 100);
%     exp_model_abs = zeros(1, 100);
%     exp_model_ang = zeros(1, 100);
    all_runs_model_polar = [];
    all_runs_model_ang = [];
    all_runs_model_abs = [];
    all_runs_naive_polar = [];
    all_runs_naive_ang = [];
    all_runs_naive_abs = [];
    
    for runnum = 1:total_runs
        run_index = (modelData(:, 1) == runnum);
        current_run_model = modelData(run_index, [2 3 4 5]);
        run_index = (naiveData(:, 1) == runnum);
        current_run_naive = naiveData(run_index, [2 3 4 5]);
        
        [model_polar, model_ang, model_abs] = orderParams(current_run_model, 1);
        [naive_polar, naive_ang, naive_abs] =  orderParams(current_run_naive, 1);
        
        all_runs_model_polar = cat(3, all_runs_model_polar, model_polar);
        all_runs_model_ang = cat(3, all_runs_model_ang, model_ang);
        all_runs_model_abs = cat(3, all_runs_model_abs, model_abs);
        all_runs_naive_polar = cat(3, all_runs_naive_polar, naive_polar);
        all_runs_naive_ang = cat(3, all_runs_naive_ang, naive_ang);
        all_runs_naive_abs = cat(3, all_runs_naive_abs, naive_abs);
        
%         exp_naive_polar(1, runnum) = norm(naive_polar - exp_polar, 2);
%         exp_naive_ang(1, runnum) = norm(naive_ang - exp_ang, 2);
%         exp_naive_abs(1, runnum) = norm(naive_abs - exp_abs, 2);
%         exp_model_polar(1, runnum) = norm(model_polar - exp_polar, 2);
%         exp_model_abs(1, runnum) = norm(model_ang - exp_ang, 2);
%         exp_model_ang(1, runnum) = norm(model_abs - exp_abs, 2);
        
%         polarName = strcat('polarPlotNaive', num2str(expnum), 'run',  num2str(runnum));
%         angName = strcat('angPlotNaive', num2str(expnum), 'run',  num2str(runnum));
%         absName = strcat('absPlotNaive', num2str(expnum), 'run',  num2str(runnum));
%         makeOrderParamPlot(naive_polar, strcat(polarName, '.png'));
%         makeOrderParamPlot(naive_ang, strcat(angName, '.png'));
%         makeOrderParamPlot(naive_abs, strcat(absName, '.png'));
%         
        
%         polarName = strcat('polarPlotModel', num2str(expnum), 'run',  num2str(runnum));
%         angName = strcat('angPlotModel', num2str(expnum), 'run',  num2str(runnum));
%         absName = strcat('absPlotModel', num2str(expnum), 'run',  num2str(runnum));
%         makeOrderParamPlot(model_polar, strcat(polarName, '.png'));
%         makeOrderParamPlot(model_ang, strcat(angName, '.png'));
%         makeOrderParamPlot(model_abs, strcat(absName, '.png'));
        
        %close all
        runnum
        
    end
    
    names = {'polarPlotNaive', 'angPlotNaive', 'absPlotNaive', 'polarPlotModel', 'angPlotModel', 'absPlotModel'};
    %datas = {all_runs_naive_polar, all_runs_naive_ang, all_runs_naive_abs, all_runs_model_polar, all_runs_model_ang, all_runs_model_abs};
    %this may qualify for the most disgusting code I have ever written
    for indx = 1:6
        %data = {all_runs_naive_polar, all_runs_naive_ang, all_runs_naive_abs, all_runs_model_polar, all_runs_model_ang, all_runs_model_abs}
        if indx == 1
            data = all_runs_naive_polar;
        elseif indx == 2
            data = all_runs_naive_ang;
        elseif indx == 3
            data = all_runs_naive_abs;
        elseif indx == 4
            data = all_runs_model_polar;
        elseif indx == 5
            data = all_runs_model_ang;
        elseif indx == 6
            data = all_runs_model_abs;
        end
            
        
        
        
        name = strcat(names{indx}, 'Exp', num2str(expnum));
        
        s = std(data, 0, 3);
        csvwrite(strcat(name, 'StandardDev', '.csv'), s)
        
        t = mean(data, 3);
        csvwrite(strcat(name, 'Average', '.csv'), t)
        
        %saving both png and figs of each
        makeOrderParamPlotAxes(s, strcat(name, 'StandardDev', '.png'), scale);
        makeOrderParamPlotAxes(s, strcat(name, 'StandardDev'), scale);
        makeOrderParamPlotAxes(t, strcat(name, 'Average', '.png'), scale);
        makeOrderParamPlotAxes(t, strcat(name, 'Average'), scale);
        
        
    end
    
%     csvwrite(strcat('polarPlotNaiveExp', num2str(expnum), '.csv'), exp_naive_polar);
%     csvwrite(strcat('angPlotNaiveExp', num2str(expnum), '.csv'), exp_naive_ang);
%     csvwrite(strcat('absPlotNaiveExp',  num2str(expnum), '.csv'), exp_naive_abs);
%     
%     csvwrite(strcat('polarPlotModelExp', num2str(expnum), '.csv'), exp_model_polar);
%     csvwrite(strcat('angPlotModelExp', num2str(expnum), '.csv'), exp_model_ang);
%     csvwrite(strcat('absPlotModelExp', num2str(expnum), '.csv'), exp_model_abs);
    
    exp_done = expnum %print statement for progress
end
