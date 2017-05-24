function write_fig_300_dpi(figHandle, fileName, dims)
    %optionally pass in dims to manually define figure dimensions
    %https://www.mathworks.com/matlabcentral/newsreader/view_thread/287268
    res=300; %resolution (dpi) of final graphic
    figHandle = gcf;
    figpos=getpixelposition(figHandle);
    resolution=get(0,'ScreenPixelsPerInch');
    if nargin == 3 %if the caller gave dimensions, use those
        size = dims(:);
    else
        size = [7.5*.9 8.75*.9];
    end
    set(figHandle,'paperunits','inches','paperposition',[0 0 transpose(size(:))]); %scaled by 90percent to make room for caption
    path='C:\Users\mju\Desktop\';
    print(figHandle,fullfile(path,fileName),'-dtiff',['-r',num2str(res)],'-opengl')
end