function subsampled_img = myShrinkImageByFactorD(d, img)
    subsampled_img = img(1:d:end, 1:d:end);