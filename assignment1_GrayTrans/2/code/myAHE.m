function out = myAHE(img, windowSize)

    w = floor(windowSize / 2);

    [m, n, d] = size(img);
    
    % eqImg = blockproc(img, [d d], @equalize);
    % eqImg = nlfilter(img, [d d], @equalize);
    h = waitbar(0, 'running AHE');
    step = 0;
    steps = d * m;
    for kk = 1:d
        for ii = 1:m
            for jj = 1:n
                t = max(1, ii - w + 1);
                b = min(ii + w, m);
                l = max(1, jj - w + 1);
                r = min(jj + w, n);
                window = img(t:b, l:r, kk);   
                out(ii, jj, kk) = equalize(window, [ii - t + 1, jj - l + 1]);
            end
            step = step + 1;
            waitbar(step / steps);
        end
    end
    close(h);

    function out = equalize(block, pos)
        [bm, bn] = size(block);
        N = bm * bn;
        [counts, x] = imhist(block);
        probs = counts / N;
        cdf = cumsum(probs);
        out = uint8(255 * cdf(block(pos(1), pos(2)) + 1)); 
    end
end