function out = nonMaxSuppression(I)
    
    I = imgaussfilt(I, 1);

    [Gx, Gy] = imgradientxy(I); 
    [~, Gdir] = imgradient(Gx, Gy);

    [m, n] = size(Gdir);
    
    out = zeros(m, n);
    for ii = 2:m-1
        for jj = 2:n-1
            dir = abs(Gdir(ii, jj));
            if (dir <= 22.5 || dir > 157.5)
                out(ii, jj) = I(ii, jj) > I(ii-1, jj) && I(ii, jj) > I(ii+1, jj);
            elseif (dir <= 67.5)
                out(ii, jj) = I(ii, jj) > I(ii-1, jj-1) && I(ii, jj) > I(ii+1, jj+1);
            elseif (dir <= 112.5)
                out(ii, jj) = I(ii, jj) > I(ii, jj-1) && I(ii, jj) > I(ii, jj+1);
            elseif (dir <= 157.5)
                out(ii, jj) = I(ii, jj) > I(ii-1, jj+1) && I(ii, jj) > I(ii+1, jj-1);
            end
        end
    end

end