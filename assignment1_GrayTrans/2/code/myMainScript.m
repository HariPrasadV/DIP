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
tic;

% barbara -----------
barbaraImg = imread('../data/barbara.png');
heBarbaraImg = myHE(barbaraImg);

figure();

subplot(1, 2, 1);
imagesc(barbaraImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(1, 2, 2);
imagesc(heBarbaraImg);
title('histogram equalized');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/b/barbara.png';
saveas(gcf, location);
disp(strcat('saved histogram equalized `barbara.png` as `', location, '`'));

% canyon ---
canyonImg = imread('../data/canyon.png');
heCanyonImg = myHE(canyonImg);

figure();

subplot(2, 1, 1);
imagesc(canyonImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(heCanyonImg);
title('histogram equalized');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/b/canyon.png';
saveas(gcf, location);
disp(strcat('saved histogram equalized `canyon.png` as `', location, '`'));

% TEM --------
TEMImg = imread('../data/TEM.png');
heTEMImg = myHE(TEMImg);

figure();

subplot(2, 1, 1);
imagesc(TEMImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(heTEMImg);
title('histogram equalized');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/b/TEM.png';
saveas(gcf, location);
disp(strcat('saved histogram equalized `TEM.png` as `', location, '`'));

toc;

%% Q2.c AHE

% TEM AHE -------------------
tic;

TEMImg = imread('../data/TEM.png');
aheTEMImg = myAHE(TEMImg, 100);

figure();

subplot(2, 1, 1);
imagesc(TEMImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(aheTEMImg);
title('adaptive histogram equalized');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/c/TEM.png';
saveas(gcf, location);
disp(strcat('saved adaptive histogram equalized `TEM.png` as `', location, '`'));

%% canyon AHE ---------

canyonImg = imread('../data/canyon.png');
aheCanyonImg = myAHE(canyonImg, 100);

figure();

subplot(2, 1, 1);
imagesc(canyonImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(aheCanyonImg);
title('AHE, w = 100');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/c/canyon.png';
saveas(gcf, location);
disp(strcat('saved adaptive histogram equalized `canyon.png` as `', location, '`'));

% barbara AHE --------------------
tic;

barbaraImg = imread('../data/barbara.png');
aheBarbaraImg = myAHE(barbaraImg, 100);

figure();

subplot(1, 2, 1);
imagesc(barbaraImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(1, 2, 2);
imagesc(aheBarbaraImg);
title('AHE, w = 100');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/c/barbara.png';
saveas(gcf, location);
disp(strcat('saved adaptive histogram equalized `barbara.png` as `', location, '`'));

toc;


%% Q2.d - CLAHE
tic;

% TEM ---------------

TEMImg = imread('../data/TEM.png');
claheTEMImg = myCLAHE(TEMImg, 100, 0.005);

figure();

subplot(2, 1, 1);
imagesc(TEMImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(claheTEMImg);
title('CLAHE, w = 100, threshold = 0.005');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/d/TEM-0.005.png';
saveas(gcf, location);
disp(strcat('saved CALHE `TEM.png` as `', location, '`'));


% barbara -------
barbaraImg = imread('../data/barbara.png');
claheBarbaraImg = myCLAHE(barbaraImg, 100, 0.005);

figure();

subplot(1, 2, 1);
imagesc(barbaraImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(1, 2, 2);
imagesc(claheBarbaraImg);
title('CLAHE, w = 100, threshold = 0.005');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/d/barbara.png';
saveas(gcf, location);
disp(strcat('saved CLAHE `barbara.png` as `', location, '`'));

% canyon ---------

canyonImg = imread('../data/canyon.png');
claheCanyonImg = myCLAHE(canyonImg, 200, 0.05);

figure();

subplot(2, 1, 1);
imagesc(canyonImg);
title('original');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

subplot(2, 1, 2);
imagesc(claheCanyonImg);
title('CLAHE, w = 200, threshold = 0.05');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

location = '../images/d/canyon.png';
saveas(gcf, location);
disp(strcat('saved CLAHE `canyon.png` as `', location, '`'));

toc;