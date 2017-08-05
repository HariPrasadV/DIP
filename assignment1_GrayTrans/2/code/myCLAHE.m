function out = myCLAHE(img, threshold)
    
    [m, n, d] = size(img);
    N = m * n;
    for ii = 1:d
        [counts, ~] = imhist(img(:,:,ii));
        probs = counts / N;
        
        % plot(probs)
        sumAboveThreshold = sum(max(0, probs - threshold));
        extraMass = sumAboveThreshold / 256;
        
        for jj = 1:256
            if probs(jj) > threshold
                probs(jj) = threshold;
            end
        end
        
        probs = probs + extraMass;
        
        % figure();
        % plot(probs)
        
        cdf = cumsum(probs);
        T = 255 * cdf;
        out(:,:,ii) = uint8(T(img(:,:,ii) + 1));
    end
    
    