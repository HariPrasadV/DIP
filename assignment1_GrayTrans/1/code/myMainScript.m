%% MyMainScript
myNumOfColors = 200;
myColorScale = [[0:1/(myNumOfColors-1):1]' , ... 
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]'];

%% Q1.a - subsampling
tic;
sub_d2 = myShrinkImageByFactorD(2);
sub_d3 = myShrinkImageByFactorD(3);

fig = figure('Visible','off');

subplot(1, 2, 1);
imagesc(sub_d2);
title('subsampled with d = 2');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(1, 2, 2);
imagesc(sub_d3);
title('subsampled with d = 3');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

saveas(fig, '../images/circles.png');
disp('subsampled images saved as `circles.png` in images/');
toc;

%%  Q1.b - bilinear interpolation
tic;

fig = figure('Visible','off');

% get the interpolated image of barbara
interpolated_img = myBilinearInterpolation();

imagesc(interpolated_img);
title('bilinearly interpolated');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

saveas(fig, '../images/barbaraInterpolated.png');
disp('interpolated image saved as `barbaraInterpolated.png` in images/');

toc;
