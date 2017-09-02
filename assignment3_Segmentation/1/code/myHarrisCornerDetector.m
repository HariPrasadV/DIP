myNumOfColors = 200;
myColorScale = [[0:1/(myNumOfColors-1):1]', ... 
                [0:1/(myNumOfColors-1):1]', ...
                [0:1/(myNumOfColors-1):1]'];

I = load('../data/boat.mat');
I = I.imageOrig;
I = mat2gray(I);

[Ix, Iy] = imgradientxy(I); 
[Imag, Idir] = imgradient(Ix, Iy);

Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

[m, n] = size(I);

%%
gaussf = fspecial('gaussian', [9, 9], 2);
Sx2 = conv2(Ix2, gaussf, 'same');
Sy2 = conv2(Iy2, gaussf, 'same');
Sxy = conv2(Ixy, gaussf, 'same');

sumf = ones(5, 5);
Sx2 = conv2(Sx2, sumf, 'same');
Sy2 = conv2(Sy2, sumf, 'same');
Sxy = conv2(Sxy, sumf, 'same');

%%
cornerMeaure = zeros(m, n);

R = zeros(m, n);
H = zeros(2, 2);
k = 0.04;
for ii = 1:m
    for jj = 1:n
        H = [Sx2(ii, jj), Sxy(ii, jj);
             Sxy(ii, jj), Sy2(ii, jj)];
        R(ii, jj) = det(H) - k * (trace(H)^2);
    end
end


cornerMeasure = mat2gray((R > 10) * 250);
superposed = mat2gray(cornerMeasure + I);

% figure();
% imagesc(cornerMeasure);
% colormap (myColorScale);
% daspect ([1 1 1]);
% axis tight;
% colorbar;

figure();
imagesc(superposed);
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar


%%
figure();
imagesc(I);
colormap (myColorScale);
daspect ([1 1 1]);
axis tight;
colorbar;
title('original image');