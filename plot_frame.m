%aphiddata = load('aphiddata.csv');
%halfFrame = [2302; 2823; 2825; 2704; 2704; 2610; 2666; 2709; 2941];
%lastFrame = [4605; 5647; 5651; 5409; 5409; 5221; 5332; 5418; 5883];
%amended because the last frames of 2 and 6 had 1 aphid each and earlier
%had more.
%lastFrame = [4605; 5644; 5651; 5409; 5409; 5220; 5332; 5418; 5883];
han = figure;
for expnum = 1:9
    indx = ( aphiddata(:,1) == expnum);
    simfxy = aphiddata(indx, [3, 4, 5]);
    f1 = 2; %the first frame in the experimental data is numbered 2
    %f1 = halfFrame(expnum);
    %f1 = lastFrame(expnum);
    
    fig = subplot(3,3,expnum); 
    
    %p is of form [left, bottom, width, height]
    p = get(fig, 'pos');
    
    p(3) = p(3) + 0.05;
    p(4) = p(4) + 0.05;
    %make row-wise alignments correct
    if expnum < 4 %row 1
        p(2) = p(2) - 0.04;
    elseif expnum < 7 %row 2
        p(2) = p(2) - 0.06;
    else %row 3
        p(2) = p(2) - 0.08;
    end
    
    %make column-wise alignments correct
    if mod(expnum,3) == 1 %column 1
        p(1) = p(1) - 0.12;
    elseif mod(expnum, 3) == 2 %column 2
        p(1) = p(1) - 0.16;
    else %column 3
        p(1) = p(1) - 0.2;
    end
    
    set(fig, 'pos', p);
    
    indx = ( simfxy(:,1) == f1);    
    f1data = simfxy(indx, :);
    %fname = strcat('frame_', num2str(f1), '_exp_', num2str(expnum));
    scatter(f1data(:, 2), f1data(:, 3), 4, 'filled');
    rectangle('Position',[-.2, -.2, .4, .4],'Curvature',[1 1])
    frameTitle = ['Video ' num2str(expnum)];
    title(fig, frameTitle);
    set(gca,'FontName','Times New Roman','FontSize',10);
    %set(gca,'XTick',[-0.2:.1:0.2])
    %set(gca,'YTick',[-0.2:.1:0.2])
    axis([-.25 .25 -.25 .25]);
    axis off
    pbaspect([1 1 1])
    
    %saveas(han, char(fname), 'png');
end

set(han,'color','w');
%set(han, 'Position', [x y width height])
%set(han, 'Resolution', 600);
%saveas(han, char(fname), 'tif');
fname = 'firstFrames';
%set(gca,'LooseInset',get(gca,'TightInset'))
write_fig_300_dpi(han, fname);