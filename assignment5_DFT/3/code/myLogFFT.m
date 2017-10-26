function myLogFFT
x = load('../data/image_low_frequency_noise.mat');
im = uint8(x.Z);
[m,n] = size(im);
figure;
imshow(im);

y = fftshift(fft2(im));
y1 = log(abs(y)+1);
figure;
imagesc(y1,[0 max(max(y1))]);
colorbar

notchFilt = ones(size(im));
%notchFilt(:,134) = zeros(m,1);
%notchFilt(:,124) = zeros(m,1);
notchFilt(139,134) = 0;
notchFilt(119,124) = 0;

y = y.*notchFilt;

figure;
i = uint8(abs(ifft2(y)));
imshow(i);

y = fftshift(fft2(i));
figure;
y1 = log(abs(y)+1);
imagesc(y1,[0 max(max(y1))]);
colorbar
end