%% MyMainScript

tic;
myUnsharpMasking('../data/lionCrop.mat', 2, 1.5);
myUnsharpMasking('../data/superMoonCrop.mat', 3, 3);
toc;
