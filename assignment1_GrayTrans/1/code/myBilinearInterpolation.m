function interpolated_img = myBilinearInterpolation()
    img = imread('../data/barbaraSmall.png');
    [m, n] = size(img);
    mq = 3 * m - 2;
    nq = 2 * n - 1;
    interpolated_img = zeros(mq, nq);
    
    verticalScale = m / mq;
    horizontalScale = n / nq;
    
    img = [img img(:, end)];
    img = [img; img(end, :)];
   
    for ii = 1:mq
        for jj = 1:nq            
           r = (ii - 1) * verticalScale + 1;
           c = (jj - 1) * horizontalScale + 1;
           
           r1 = floor(r);
           c1 = floor(c);
           
           q11 = img(r1, c1);
           q12 = img(r1, c1 + 1);
           q21 = img(r1 + 1, c1);
           q22 = img(r1 + 1, c1 + 1);
           
           r2r = (r1 + 1 - r);
           r1r = (r - r1);
           c2c = (c1 + 1 - c);
           c1c = (c - c1);
           
           interpolated_img(ii, jj) = q11 * (r2r * c2c) + ...
                 q12 * (r2r * c1c) + ...
                 q21 * (r1r * c2c) + ...
                 q22 * (r1r * c1c);
        end
    end

    
    