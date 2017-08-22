function myBilateralFiltering(imgPath, sigmaSpatial, sigmaIntensity)
myNumOfColors = 200; 
myColorScale = [ [0:1/(myNumOfColors - 1):1]' , ...  
[0:1/(myNumOfColors - 1):1]'    , [0:1/(myNumOfColors - 1):1]' ]; 


Im = load(imgPath);
img = Im.imageOrig;
maxIntensity = max(max(img));
[m, n] = size(img);
img = img/maxIntensity;
imgOrig = img;

figure;
subplot(1,3,1);
imagesc(img);
title("Original");
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar



img = img + (0.05*randn(m, n));

subplot(1,3,2);
imagesc(img);
title("Corrupted");
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar


img2 = nlfilter(img, [5,5], @filt);
subplot(1,3,3);
imagesc(img2);
title("Filtered (sigS="+string(sigmaSpatial)+", sigI="+string(sigmaIntensity) + ")");
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar

figure;
imshow(fspecial('gaussian',5,sigmaSpatial));
rmsd = sqrt(sum(sum((imgOrig-img2).^2)) / (m*n))

function x = filt(A)
    weight = gaussmf(abs(A-A(3,3)),[sigmaIntensity,0]).*fspecial('gaussian',5,sigmaSpatial);
    A1 = A.*weight;
    x = sum(sum(A1))/sum(sum(weight));
end

end

