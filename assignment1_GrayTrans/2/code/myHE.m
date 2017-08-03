clear;
img = imread('../data/TEM.png');
   
[counts, x] = imhist(img);

[m, n] = size(img);
N = m * n;

probs = counts / N;
cdf = cumsum(probs);

T = floor(255 * cdf);
eqImg = T(img + 1);

myNumOfColors = 200;
myColorScale = [[0:1/(myNumOfColors-1):1]' , ... 
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]'];

figure();

subplot(2, 1, 1);
imagesc(eqImg);
title('');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(img);
title('');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;