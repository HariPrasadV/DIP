%% MyMainScript

tic;
myPatchBasedFiltering('../data/barbara.mat', 0.45);
myPatchBasedFiltering('../data/barbara.mat', 0.45*0.9);
myPatchBasedFiltering('../data/barbara.mat', 0.45*1.1);
toc;
