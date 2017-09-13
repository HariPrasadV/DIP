%% MyMainScript

parameters = [
        8, 24, 100, 5;
        8, 24, 100, 10;
        8, 24, 100, 20;
        
        8, 24, 50, 10;
        8, 24, 200, 10;
        8, 24, 300, 10;
        
        16, 16, 200, 10;
        
        24, 8, 200, 10;
    ];

% myMeanShiftSegmentation(16, 16, 200, 10);
% myMeanShiftSegmentation(8, 24, 100, 5);
% myMeanShiftSegmentation(2, 2, 200, 10); % --> not good
% myMeanShiftSegmentation(16, 24, 200, 10); % --> good
% myMeanShiftSegmentation(8, 24, 100, 5);

for i = 1:8
    tic;
    sigma_S = parameters(i, 1);
    sigma_I = parameters(i, 2);
    noOfNeighbours = parameters(i, 3);
    max_iter = parameters(i, 4);
    myMeanShiftSegmentation(sigma_S, sigma_I, noOfNeighbours, max_iter);
    toc;
end
