function out = myHarrisCornerDetector(sigma_w, sigma_der, k, threshold, showImages)
    % good values
    % sigma_w = 1;
    % sigma_der = 1;
    % k = 0.04;
    % threshold = 2;

    % read and normalize image
    I = load('../data/boat.mat');
    I = I.imageOrig;
    I = mat2gray(I);

    % calculate gradients in x and y directions
    [Ix, Iy] = imgradientxy(I); 
    gaussf = fspecial('gaussian', [3, 3], sigma_der);
    Ix = conv2(Ix, gaussf, 'same');
    Iy = conv2(Iy, gaussf, 'same');

    % calculate product of derivatives
    Ix2 = Ix .* Ix;
    Iy2 = Iy .* Iy;
    Ixy = Ix .* Iy;

    [m, n] = size(I);

    % apply a gaussian filter to prod of derivatives 
    gaussf = fspecial('gaussian', [9, 9], sigma_w);
    Sx2 = conv2(Ix2, gaussf, 'same');
    Sy2 = conv2(Iy2, gaussf, 'same');
    Sxy = conv2(Ixy, gaussf, 'same');

    % sum of prod of derivatives
    sumf = ones(3, 3);
    Sx2 = conv2(Sx2, sumf, 'same');
    Sy2 = conv2(Sy2, sumf, 'same');
    Sxy = conv2(Sxy, sumf, 'same');

    % stores eigenvalues of the structure tensor, evaluated at each pixel.
    E1 = zeros(m, n); 
    E2 = zeros(m, n);

    R = zeros(m, n);
    H = zeros(2, 2);
    for ii = 1:m
        for jj = 1:n
            H = [Sx2(ii, jj), Sxy(ii, jj);
                 Sxy(ii, jj), Sy2(ii, jj)];

            e = eig(H);
            E1(ii, jj) = e(1);
            E2(ii, jj) = e(2);

            R(ii, jj) = prod(e) - k * (sum(e)^2);
        end
    end

    % apply threshold on cornerness value
    cornerMeasure = mat2gray(R > threshold);

    % apply non max suppression
    cornerMeasureNMS = nonMaxSuppression(cornerMeasure);
    out = mat2gray(cornerMeasureNMS + I);
    
    if showImages == 1
        % show images
        showImg(mat2gray(Ix), 'x derivative');
        showImg(mat2gray(Iy), 'y derivative');

        showImg(mat2gray(E1), 'first eigen value');
        showImg(mat2gray(E2), 'second eigen value');

        showImg(mat2gray(cornerMeasure), 'corner measure');
        showImg(mat2gray(cornerMeasure + I), 'superposed with original');

        showImg(mat2gray(cornerMeasureNMS), 'corner measure (non-max suppressed)');
        
        fig_title = strcat(['sigma_w=', num2str(sigma_w), ...
                    ', sigma_{Ix, Iy}=', num2str(sigma_der), ... 
                    ', k=', num2str(k), ...
                    ', threshold=', num2str(threshold)]);
        showImg(out, fig_title);
    end
end














