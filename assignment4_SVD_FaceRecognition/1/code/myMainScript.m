%% MyMainScript

%% ORL database, using eig() function
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
myFaceRecogORL(k_vals);
toc;

%% ORL database, using SVD
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
myFaceRecogSVD_ORL(k_vals);
toc;

%% Yale database
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
myFaceRecogYale(k_vals, 0);
toc;

%% Yale database, excluding top3 eigenfaces
tic;
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
myFaceRecogYale(k_vals, 1);
toc;