%% MyMainScript

%% Your code here
%k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
k = [10];
% figure;
% tic;
% myFaceRecog(k);
% toc;
% 
% figure;
% tic;
% myFaceRecogSVD(k);
% toc;

k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];

figure;
tic;
YaleFaceRecog(k,0);
toc;

figure;
tic;
YaleFaceRecog(k,1);
toc;