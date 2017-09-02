function [] = myMeanShiftSegmentation(sigma_S, sigma_I, noOfNeighbours, max_iter)

    % % sample paramter values
    % sigma_S = 16;
    % sigma_I = 48;
    % noOfNeighbours = 100; 
    % max_iter = 10;

    I = imread('../data/baboonColor.png');

    % normalize intensity values to [0, 1]
    I = mat2gray(I);

    % apply gaussian filter with ? = 1 pixel width
    I = imgaussfilt(I, 1);

    % subsample image
    I = imresize(I, 0.5);

    % get size of the image
    [m, n, d] = size(I);

    % get number of pixels in one layer
    N = m * n;

    % produce a 5D feature space for KNN search
    X = zeros(N, 5);
    index = 1;
    for ii = 1:m
        for jj = 1:n
            X(index, :) = [ii, jj, I(ii, jj, 1), I(ii, jj, 2), I(ii, jj, 3)];
            index = index + 1;
        end
    end


    % apply spatial sigma
    X(:, 1:2) = X(:, 1:2) / (1.4142 * sigma_S);
    % apply intensity sigma
    X(:, 3:5) = X(:, 3:5) * 255 / (1.4142 * sigma_I);

    disp('running mean shift segmentation..');
    disp(strcat(['sigma_S : ', num2str(sigma_S)]));
    disp(strcat(['sigma_I : ', num2str(sigma_I)]));
    disp(strcat(['no. of neighbours : ', num2str(noOfNeighbours)]));
    disp(strcat(['no. of iterations : ', num2str(max_iter)]));

    ii = 0;
    while (ii < max_iter)

        disp(strcat(['iteration : ', num2str(ii + 1)]));

        % do a KNN search
        % Idx(i, :) -> indices of nearest neighbours of point i
        % D(i, :) -> distance of nearest neighbours of point i
        % both `Idx` and `D` are of size (N x noOfNeighbours)
        [Idx, D] = knnsearch(X, X, 'k', noOfNeighbours);
        
        % gaussian weights (sigma was applied earlier)
        % weights -> (N x noOfNeighbours)
        weights = exp(-(D .^ 2));
        
        % get sum of weights (denominator)
        weights_sum = sum(weights, 2);
        
        weights = cat(3, weights, weights, weights);
        weights_sum = cat(3, weights_sum, weights_sum, weights_sum);
        
        a = reshape(X(Idx, 3:5), [N, noOfNeighbours, 3]); 
        X(:, 3:5) = sum(a .* weights, 2) ./ weights_sum;

        ii = ii + 1;
    end

    
    disp('saving ouput image..')

    % initialize output image to zeros
    O = zeros(m, n, d);

    index = 1;
    for ii = 1:m
        for jj = 1:n
            O(ii, jj, :) = X(index, 3:5);
            index = index + 1;
        end
    end

    % normalize and resize output image
    O = mat2gray(O);
    O = imresize(O, 2);

    
    fig_title = strcat(['sigma_s=', num2str(sigma_S), ...
                    ', sigma_r=', num2str(sigma_I), ... 
                    ', nNeighs=', num2str(noOfNeighbours), ...
                    ', nIters=', num2str(max_iter)]);

    figure();
    suptitle(fig_title);

    subplot(1, 2, 1);
    imshow(I), colorbar;
    title('original');

    subplot(1, 2, 2);
    imshow(O), colorbar;
    title('segmented');

    set(findall(gcf,'-property','FontSize'),'FontSize',20)

    % save image as `seg_<sigma_S>_<sigma_I>_<noOfNeighbours>_<max_iter>.png`
    file_name = strcat(['../images/seg_', num2str(sigma_S), '_', ...
                                num2str(sigma_I), '_'], ...
                                num2str(noOfNeighbours), '_', ...
                                num2str(max_iter), '.png');
    saveas(gcf, file_name);
    disp('done');
end




