function myAHE()

    clear;
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]' , ... 
        [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]'];

    img = imread('../data/TEM.png');
    windowSize = 100;
    d = windowSize / 2;    % window size

    [m, n] = size(img);
    eqImg = zeros(m, n);
    
    tic;
    % eqImg = blockproc(img, [d d], @equalize);
    % eqImg = nlfilter(img, [d d], @equalize);
    
    h = waitbar(0,'Please wait...');
    for ii = 1:m
        for jj = 1:n
            t = max(1, ii - d + 1);
            b = min(ii + d, m);
            l = max(1, jj - d + 1);
            r = min(jj + d, n);
            window = img(t:b, l:r);   
            eqImg(ii, jj) = equalize(window, [ii - t + 1, jj - l + 1]);
        end
        waitbar(ii / m);
    end
    close(h);
    toc;

    figure();

    imagesc(eqImg);
    title('');
    colormap (myColorScale);
    % colormap jet;
    daspect ([1 1 1]);
    axis tight;
    colorbar;

    function out = equalize(block, pos)
        [bm, bn] = size(block);
        N = bm * bn;
        [counts, x] = imhist(block);
        probs = counts / N;
        cdf = cumsum(probs);
        out = floor(255 * cdf(block(pos(1), pos(2)) + 1)); 
    end

end