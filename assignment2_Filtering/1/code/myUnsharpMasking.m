function myUnsharpMasking(imgPath, sigma, fact)
im = load(imgPath);
imgOrig = im.imageOrig;
imgGauss = imgaussfilt(imgOrig, sigma);
imgDiff = imabsdiff(imgGauss, imgOrig);
imgSharper = imadd(imgOrig, -1*fact*imgDiff);
figure;
subplot(1,2,1);
imshow(imgOrig)
subplot(1,2,2);
imshow(imgSharper)