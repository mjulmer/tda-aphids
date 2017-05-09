function write_fig_600_dpi(figHandle, fileName)
    %https://www.mathworks.com/matlabcentral/newsreader/view_thread/287268
    res=600; %resolution (dpi) of final graphic
    figHandle = gcf;
    figpos=getpixelposition(figHandle);
    resolution=get(0,'ScreenPixelsPerInch');
    %set(figHandle,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); 
    path='C:\Users\mju\Desktop\';
    print(figHandle,fullfile(path,fileName),'-dtiff',['-r',num2str(res)],'-opengl')
end