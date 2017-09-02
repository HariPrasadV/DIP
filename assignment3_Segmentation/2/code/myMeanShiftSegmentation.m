
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

% parameters
max_iter = 5;
sigma_S = 2;
sigma_I = 16;
noOfNeighbours = 200;

% apply spatial sigma
X(:, 1:2) = X(:, 1:2) / (1.4142 * sigma_S);
% apply intensity sigma
X(:, 3:5) = X(:, 3:5) * 255 / (1.4142 * sigma_I);

disp('running mean shift segmentation..');
disp(strcat(['?_S : ', num2str(sigma_S)]));
disp(strcat(['?_I : ', num2str(sigma_I)]));
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
    
    % for each point, calculate neighbour weights
    for jj = 1:N
        
        % gaussian weights (sigma was applied earlier)
        % weights -> (noOfNeighbours x 1)
        weights = exp(-(D(jj, :) .^ 2))';
        
        % get sum of weights (denominator)
        weights_sum = sum(weights);
        
        weights_3 = [weights, weights, weights];
        X(jj, 3:5) = sum(weights_3 .* X(Idx(jj, :), 3:5)) / weights_sum;
        
    end
    
    ii = ii + 1;
end


% initialize output image to zeros
O = zeros(m, n, d);

index = 1;
for ii = 1:m
    for jj = 1:n
        O(ii, jj, :) = X(index, 3:5);
        index = index + 1;
    end
end

% normalize image
O = mat2gray(O);

figure();
imshow(O), colorbar;







