%% MyMainScript

%% Your code here
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
myFaceRecogSVD_ORL(k_vals);
toc;

%%
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
myFaceRecogORL(k_vals);
toc;

%%
