%% MyMainScript
myNumOfColors = 200;
myColorScale = [[0:1/(myNumOfColors-1):1]' , ... 
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]'];

%% Q2.a - linear contrast stretching
tic;
disp('linear contrast stretching..');

% barbara -----------

barbaraImg = imread('../data/barbara.png');
lcsBarbaraImg = myLinearContrastStretching(barbaraImg);

figure();

subplot(1, 2, 1);
imagesc(barbaraImg);
title('original');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(1, 2, 2);
imagesc(lcsBarbaraImg);
title('linearly contrast stretched');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/a/barbara.png';
saveas(gcf, location);
disp(strcat('saved linearly contrast stretched `barbara.png` as `', location, '`'));


% canyon --------
canyonImg = imread('../data/canyon.png');
lcsCanyonImg = myLinearContrastStretching(canyonImg);

figure();

subplot(2, 1, 1);
imagesc(canyonImg);
title('original');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(lcsCanyonImg);
title('linearly contrast stretched');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/a/canyon.png';
saveas(gcf, location);
disp(strcat('saved linearly contrast stretched `canyon.png` as `', location, '`'));

% TEM --------
TEMImg = imread('../data/TEM.png');
lcsTEMImg = myLinearContrastStretching(TEMImg);

figure();

subplot(2, 1, 1);
imagesc(TEMImg);
title('original');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(lcsTEMImg);
title('linearly contrast stretched');
colormap (myColorScale);
% colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/a/TEM.png';
saveas(gcf, location);
disp(strcat('saved linearly contrast stretched `TEM.png` as `', location, '`'));
toc;


%% Q2.b - HE