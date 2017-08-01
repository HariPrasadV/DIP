myNumOfColors = 200;
myColorScale = [[0:1/(myNumOfColors-1):1]' , ... 
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]'];

img = imread('../data/canyon.png');
img = rgb2gray(img);
minIntensity = min(min(img));
maxIntensity = max(max(img));

% main expression
newImg = (img - minIntensity) * (255 / (maxIntensity - minIntensity));

figure();

% subplot(1, 2, 1);
imagesc(img);
title('barbara original');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

figure();
% subplot(1, 2, 2);
imagesc(newImg);
title('barbara contrast stretched');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;
% saveas(gcf, '../images/barbaraStretched.png');
