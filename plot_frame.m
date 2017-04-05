%aphiddata = load('aphiddata.csv');
halfFrame = [2302; 2823; 2825; 2704; 2704; 2610; 2666; 2709; 2941];
%lastFrame = [4605; 5647; 5651; 5409; 5409; 5221; 5332; 5418; 5883];
%amended because the last frames of 2 and 6 had 1 aphid each and earlier
%had more.
lastFrame = [4605; 5644; 5651; 5409; 5409; 5220; 5332; 5418; 5883];

for expnum = 1:9
    indx = ( aphiddata(:,1) == expnum);
    simfxy = aphiddata(indx, [3, 4, 5]);
    %f1 = 0;
    f2 = halfFrame(expnum);
    f3 = lastFrame(expnum);
    
%     indx = ( simfxy(:,1) ==f1);    
%     f1data = simfxy(indx, :);
%     fname = strcat('frame_', num2str(f1), '_exp_', num2str(expnum));
%     han = figure;
%     scatter(f1data(:, 2), f1data(:, 3), 'filled');
%     title(strcat('Frame ', num2str(f1)));
%     axis([-.3 .3 -.3 .3]);
%     saveas(han, char(fname), 'png');
    
    

    indx = ( simfxy(:,1) == f2);    
    f2data = simfxy(indx, :);
    fname = strcat('frame_', num2str(f2), '_exp_', num2str(expnum));
    han = figure;
    scatter(f2data(:, 2), f2data(:, 3), 'filled');
    rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
    title(strcat('Frame', num2str(f2)));
    axis([-.3 .3 -.3 .3]);
    %viscircles([0, 0], .3,'Color','b');pos = [2 4 2 2];
    saveas(han, char(fname), 'png');

    indx = ( simfxy(:,1) == f3);    
    f3data = simfxy(indx, :);
    fname = strcat('frame_', num2str(f3), '_exp_', num2str(expnum));
    han = figure;
    scatter(f3data(:, 2), f3data(:, 3), 'filled');
    rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
    title(strcat('Frame ', num2str(f3)));
    axis([-.3 .3 -.3 .3]);
    %viscircles([0,0], .2,'Color','b');
    saveas(han, char(fname), 'png');

end