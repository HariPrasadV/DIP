%% MyMainScript

tic;

sigma_w = 1;
sigma_der = 1;
k = 0.04;
threshold = 2;

myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, 1);

toc;
%%
tic;

% a good set of parameters
sigma_w = 0.5;
sigma_der = 0.5;
k = 0.06;
threshold = 0.02;
I = myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, 0);
fig_title = strcat(['sigma_w=', num2str(sigma_w), ...
                    ', sigma_{Ix, Iy}=', num2str(sigma_der), ... 
                    ', k=', num2str(k), ...
                    ', threshold=', num2str(threshold)]);
showImg(I, fig_title);
toc;

%%
tic;

sigma_w = 1;
sigma_der = 0.5;
k = 0.06;
threshold = 1;
I = myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, 0);
fig_title = strcat(['sigma_w=', num2str(sigma_w), ...
                    ', sigma_{Ix, Iy}=', num2str(sigma_der), ... 
                    ', k=', num2str(k), ...
                    ', threshold=', num2str(threshold)]);
showImg(I, fig_title);
toc;

%%
tic;

sigma_w = 2;
sigma_der = 0.5;
k = 0.06;
threshold = 1;
I = myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, 0);
fig_title = strcat(['sigma_w=', num2str(sigma_w), ...
                    ', sigma_{Ix, Iy}=', num2str(sigma_der), ... 
                    ', k=', num2str(k), ...
                    ', threshold=', num2str(threshold)]);
showImg(I, fig_title);
toc;

%%
tic;

sigma_w = 1;
sigma_der = 0.005;
k = 0.06;
threshold = 10;
I = myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, 0);
fig_title = strcat(['sigma_w=', num2str(sigma_w), ...
                    ', sigma_{Ix, Iy}=', num2str(sigma_der), ... 
                    ', k=', num2str(k), ...
                    ', threshold=', num2str(threshold)]);
showImg(I, fig_title);
toc;

