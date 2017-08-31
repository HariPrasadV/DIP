%% MyMainScript

tic;
myBilateralFiltering('~/curves/dega/1.jpg', 1, 1);
% myBilateralFiltering('../data/barbara.mat', 0.9, 1);
% myBilateralFiltering('../data/barbara.mat', 1.1, 1);
% myBilateralFiltering('../data/barbara.mat', 1, 0.9);
% myBilateralFiltering('../data/barbara.mat', 1, 1.1);
toc;
