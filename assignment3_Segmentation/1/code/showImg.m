function [] = showImg(I, title_text)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]', ... 
                [0:1/(myNumOfColors-1):1]', ...
                [0:1/(myNumOfColors-1):1]'];

    iptsetpref('ImshowAxesVisible','on');
	figure('units','normalized','outerposition',[0 0 1 1])
    imagesc(I);
    colormap (myColorScale);
    daspect ([1 1 1]);
    axis tight;
    colorbar
    title(title_text)
    
    set(findall(gcf,'-property','FontSize'),'FontSize',20)
end