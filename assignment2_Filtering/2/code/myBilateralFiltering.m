myNumOfColors = 200; 
myColorScale = [ [0:1/(myNumOfColors - 1):1]' , ...  
[0:1/(myNumOfColors - 1):1]'    , [0:1/(myNumOfColors - 1):1]' ]; 

Im = load('../data/barbara.mat');
img = Im.imageOrig;

figure;
subplot(1,3,1);
imagesc(img);
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar

maxIntensity = max(max(img));
[m, n] = size(img);
img = img + (maxIntensity*0.05*randn(m, n));

subplot(1,3,2);
imagesc(img);
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar

sigmaSpatial = 1;
sigmaIntensity = 1;
spatialFilt = fspecial('gaussian',20,sigmaSpatial);
img2 = nlfilter(img, [5,5], @filt);

subplot(1,3,3);
imagesc(img2);
colormap (myColorScale); 
daspect ([1 1 1]);  
axis tight;
colorbar

function x = filt(A)
    weight = gaussmf(abs(A-A(3,3)),[5,0]).*fspecial('gaussian',5,5);
    A1 = A.*weight;
    x = sum(sum(A1))/sum(sum(weight));
    A(3,3), x
end



