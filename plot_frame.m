aphiddata = load('aphiddata.csv');
han = figure;
for expnum = 1:9
    indx = ( aphiddata(:,1) == expnum);
    simfxy = aphiddata(indx, [3, 4, 5]);
    f1 = 2; %the first frame in the experimental data is numbered 2
    
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
    frameTitle = ['Trial ' num2str(expnum)];
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
%u = uicontrol('Style','edit','Tag','StatusBar');
%saveas(han, char(fname), 'tif');
fname = 'firstFramesSizeChange';
write_fig_300_dpi(han, fname, [7.5 8.5*.9]);