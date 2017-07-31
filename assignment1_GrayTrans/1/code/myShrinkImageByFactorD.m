function subsampled_img = myShrinkImageByFactorD(d)
    img = imread('../data/circles_concentric.png');
    subsampled_img = img(1:d:end, 1:d:end);