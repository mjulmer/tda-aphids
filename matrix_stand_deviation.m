dimension = 0;
total_runs = 100;
filtrationgap = .00005;
maxfilt = 0.2;
timesamples = 1000;
 
for expnum = 1:9    
    all_runs = load(strcat('noInteraction100h', num2str(dimension), 'exp', num2str(expnum), 'run1.csv'));
    dims = size(all_runs);
    endframe = dims(1);
    
    for runnum = 2:total_runs
        current_run = load(strcat('noInteraction100h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        all_runs = cat(3, all_runs, current_run);
    end
    
    s = std(all_runs, 0, 3);
    csvwrite(strcat('full100noInteractionStandardDevExp', num2str(expnum), '.csv'), s)
 
    t = mean(all_runs, 3);
    csvwrite(strcat('full100noInteractionAverageExp', num2str(expnum), '.csv'), t)
    
    % make our contour plot with provided contours
    y = 0:filtrationgap:maxfilt;
    x = 1:timesamples;
    for i = 1:timesamples
        x(1, i) = sampletoframe(i, timesamples, endframe);
    end
    x = .5 * x;
    han = figure;
    if dimension == 0
        contours = 2:10;
    else
        contours = 1:10;
    end
    [C, h] = contour(x, y, t, contours);
    xlabel('Time (s)');
    ylabel('Filtration parameter');
    colorbar;
    saveas(han, strcat('noInteraction100Average', 'h', num2str(dimension), 'exp', num2str(expnum), 'png'));
end
 
%this is the procedure:
% A = [1, 2; 3, 4];
% B = cat(3, A, A, A);
% S = std(B, 0, 3) %the 0 means keep the default normalization 
% T = mean(B, 3)


