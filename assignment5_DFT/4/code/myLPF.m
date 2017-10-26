function myLPF(gauss)
im = imread('../data/barbara256.png');
[m,n] = size(im);
im = padarray(im,[m/2,n/2]);
[m1,n1] = size(im);

for D = [40,80]
    y = fftshift(fft2(im));
    
    if (gauss == 0)
        filt = zeros(m1,n1);
        filt(m1/2-D:m1/2+D,n1/2-D:n1/2+D) = ones(2*D+1,2*D+1);
    else
        filt = fspecial('gauss',[m1,n1],D);
        maxf = max(max(filt));
        filt = filt./maxf;
        %filt = padarray(filt,[m/2,n/2]);
    end
    figure;
    imagesc(filt,[0 max(max(filt))]);
    colorbar
    
    y = y.*filt;
    
    figure;
    i = uint8(abs(ifft2(y)));
    i = i(m1/2-m/2+1:m1/2+m/2, n1/2-n/2+1:n1/2+n/2);
    imshow(i);
end
end