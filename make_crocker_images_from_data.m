for expnum = 1:1
    data = load(strcat('experimentalh0exp', num2str(expnum), '.csv'));
    
    frameNums = [4605; 5647; 5651; 5409; 5409; 5221; 5332; 5418; 5883];
    
    maxfilt = 0.2;
    filtrationgap = .00005;
    filtrationtimes = 0:filtrationgap:maxfilt;
    timesamples = 1000;
    endframe = frameNums(expnum);
    
    % make our contour plot with provided contours
    y = 0:filtrationgap:maxfilt;
    x = 1:timesamples;
    for i = 1:timesamples
        x(1, i) = sampletoframe(i, timesamples, endframe);
    end
    x = .5 * x;   
    contours = 1:10;
    
    han = figure;
    [C, h] = contour(x, y, data, contours);
    %[C, h] = contourf(x, y, data, contours);
    xlabel('Time \it{t}');
    ylabel('Proximity parameter \epsilon');
    colormap hsv; % or default
    colorbar;
    saveas(han, strcat('playCROCKERexp', num2str(expnum)));
    %saveas(han, strcat('noInteraction100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum)), 'png');
    write_fig_300_dpi(handle, 'FigR');
end