function myUnsharpMasking(imgPath, sigma, fact)
    im = load(imgPath);
    imgOrig = im.imageOrig;
    figure;
    subplot(1,2,1);
    imshow(imgOrig);
    colorbar 

    imgGauss = imgaussfilt(imgOrig, sigma);
    imgDiff = imgOrig - imgGauss;
    imgSharper = imgOrig + fact*imgDiff;

    subplot(1,2,2);
    imshow(imgSharper);
    colorbar 