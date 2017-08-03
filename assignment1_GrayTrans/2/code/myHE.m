function out = myHE(img)
    % img -> image (any dimension)
    % out -> histogram equalized img
    
    [m, n, d] = size(img);
    N = m * n;
    for ii = 1:d
        [counts, ~] = imhist(img(:,:,ii));
        probs = counts / N;
        cdf = cumsum(probs);
        T = floor(255 * cdf);
        out(:,:,ii) = uint8(T(img(:,:,ii) + 1));
    end