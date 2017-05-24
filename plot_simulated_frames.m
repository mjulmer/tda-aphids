%groups images by runs instead of by experiment. We generate the plots for
%nine runs because I didn't want to screw with the formatting code more than
%necessary.

whichFrame = 'middleFrame';
frameNums = [2302; 2823; 2825; 2704; 2704; 2610; 2666; 2709; 2941];

% whichFrame = 'endFrame';
% frameNums = [4605; 5644; 5651; 5408; 5409; 5220; 5331; 5418; 5883];

%not actually the last frames, because last frame of experimental was
%missing almost all of the aphids for some videos 
runsToGenerate = 1:9;
%whichModel = 'Interactive';
whichModel = 'Control';

for expnum = 1:9
    if strcmp(whichModel, 'Interactive')
        aphiddata = load(strcat('full100ModelDataExp', num2str(expnum), '.csv'));
    elseif strcmp(whichModel, 'Control')
        aphiddata = load(strcat('full100noInteractionDataExp', num2str(expnum), '.csv'));
    else
        error = 1
    end
    frame = frameNums(expnum); %because the middle/last frame is in relation to which experiment, and the same across runs
    han = figure;
    for runnum = runsToGenerate
        
        indx = ( aphiddata(:,1) == runnum);
        simfxy = aphiddata(indx, [3, 4, 5]);
        
        fig = subplot(3,3,runnum);
        
        %p is of form [left, bottom, width, height]
        p = get(fig, 'pos');
        
        p(3) = p(3) + 0.05;
        p(4) = p(4) + 0.05;
        %make row-wise alignments correct
        if runnum < 4 %row 1
            p(2) = p(2) - 0.04;
        elseif runnum < 7 %row 2
            p(2) = p(2) - 0.06;
        else %row 3
            p(2) = p(2) - 0.08;
        end
        
        %make column-wise alignments correct
        if mod(runnum,3) == 1 %column 1
            p(1) = p(1) - 0.12;
        elseif mod(runnum, 3) == 2 %column 2
            p(1) = p(1) - 0.16;
        else %column 3
            p(1) = p(1) - 0.2;
        end
        
        set(fig, 'pos', p);
        
        indx = ( simfxy(:,1) == frame);
        f1data = simfxy(indx, :);
        %fname = strcat('frame_', num2str(f1), '_exp_', num2str(expnum));
        scatter(f1data(:, 2), f1data(:, 3), 4, 'filled');
        rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
        frameTitle = ['Experiment ' num2str(runnum)];
        title(fig, frameTitle);
        set(gca,'FontName','Times New Roman','FontSize',10);
        %set(gca,'XTick',[-0.2:.1:0.2])
        %set(gca,'YTick',[-0.2:.1:0.2])
        axis([-.25 .25 -.25 .25]);
        axis off
        pbaspect([1 1 1])
    end
    
    set(han,'color','w');
    %example: middleFrameInteractiveExp3
    fname = strcat(whichFrame, whichModel, 'Exp', num2str(expnum));
    write_fig_300_dpi(han, fname);
    
end