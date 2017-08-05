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

% location = '../images/a/barbara.png';
% saveas(gcf, location);
% disp(strcat('saved linearly contrast stretched `barbara.png` as `', location, '`'));


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

% location = '../images/a/canyon.png';
% saveas(gcf, location);
% disp(strcat('saved linearly contrast stretched `canyon.png` as `', location, '`'));

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

% location = '../images/a/TEM.png';
% saveas(gcf, location);
% disp(strcat('saved linearly contrast stretched `TEM.png` as `', location, '`'));

toc;


%% Q2.b - HE

% barbara -----------
barbaraImg = imread('../data/barbara.png');
heBarbaraImg = myHE(barbaraImg);

tic;
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

% location = '../images/b/barbara.png';
% saveas(gcf, location);
% disp(strcat('saved histogram equalized `barbara.png` as `', location, '`'));


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

% location = '../images/b/canyon.png';
% saveas(gcf, location);
% disp(strcat('saved histogram equalized `canyon.png` as `', location, '`'));

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

% location = '../images/b/TEM.png';
% saveas(gcf, location);
% disp(strcat('saved histogram equalized `TEM.png` as `', location, '`'));

toc;

%% Q2.c AHE

% TEM -------------------
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

% location = '../images/c/TEM.png';
% saveas(gcf, location);
% disp(strcat('saved adaptive histogram equalized `TEM.png` as `', location, '`'));

% canyon ---------
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
title('adaptive histogram equalized, w = 100');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

% location = '../images/c/canyon.png';
% saveas(gcf, location);
% disp(strcat('saved adaptive histogram equalized `canyon.png` as `', location, '`'));

%% barbara --------------------
barbaraImg = imread('../data/barbara.png');
aheBarbaraImg = myAHE(barbaraImg, 100);

tic;
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
title('adaptive histogram equalized, w = 100');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

% location = '../images/c/barbara.png';
% saveas(gcf, location);
% disp(strcat('saved adaptive histogram equalized `barbara.png` as `', location, '`'));

toc;


%% Q2.d - CLAHE

% TEM
tic;

TEMImg = imread('../data/TEM.png');
% claheTEMImg = myCLAHE(TEMImg, 0.05);
claheTEMImg = myCLAHE(TEMImg, 0.1);

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
title('CLAHE');
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;

% location = '../images/d/TEM.png';
% saveas(gcf, location);
% disp(strcat('saved CALHE `TEM.png` as `', location, '`'));

toc;