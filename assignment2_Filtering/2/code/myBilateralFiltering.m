
myNumOfColors = 200; 
myColorScale = [ [0:1/(myNumOfColors - 1):1]' , ...  
[0:1/(myNumOfColors - 1):1]'    , [0:1/(myNumOfColors - 1):1]' ]; 

figure;
Im = imread('~/curves/dega/1.jpg');
img = Im;%.imageOrig;
%subplot(1,2,1);
imshow(img);
figure;
%maxIntensity = max(max(img))
%subplot(1,2,2);
imshow(imsharpen(imsharpen(img)));
% [m, n] = size(img);
% img = img./maxIntensity;
% imgOrig = img;
% 
% figure;
% 
% imagesc(img);
% title('Original');
% colormap (myColorScale); 
% daspect ([1 1 1]);  
% axis tight;
% colorbar
% 
% 
% 
% img = img + (0.05*randn(m, n));
% 
% figure;
% imagesc(img);
% title('Corrupted');
% colormap (myColorScale); 
% daspect ([1 1 1]);  
% axis tight;
% colorbar
% 
% 
% img2 = nlfilter(img, [5,5], @filt);
% figure;
% imagesc(img2);
% title("Filtered, sig_space="+string(sigmaSpatial)+", sig_inten="+string(sigmaIntensity));
% colormap (myColorScale); 
% daspect ([1 1 1]);  
% axis tight;
% colorbar
% 
% figure;
% imshow(fspecial('gaussian',5,sigmaSpatial));
% rmsd = sqrt(sum(sum((imgOrig-img2).^2)) / (m*n))
% 
% function x = filt(A)
%     weight = gaussmf(abs(A-A(3,3)),[sigmaIntensity,0]).*fspecial('gaussian',5,sigmaSpatial);
%     A1 = A.*weight;
%     x = sum(sum(A1))/sum(sum(weight));
% end


