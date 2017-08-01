function interpolated_img = myNearestNeighborInterpolation()
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

            rNearest = floor(r);
            if (rNearest + 1 - r < r - rNearest)
                rNearest = rNearest + 1;
            end

            cNearest = floor(c);
            if (cNearest + 1 - c < c - cNearest)
                cNearest = cNearest + 1;
            end

            interpolated_img(ii, jj) = img(rNearest, cNearest);
        end
    end