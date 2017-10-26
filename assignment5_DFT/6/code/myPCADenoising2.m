im1 = imread('../data/barbara256.png');
sigmaSq = 5;
im = double(im1) + randn(size(im1))*20;
figure;
imshow(im1);
figure;
imshow(uint8(im));
[m,n] = size(im);
N = (m-6)*(n-6);
P = zeros(49,N);
for ii = 1:m-6
    for jj = 1:n-6
        P(:,(ii-1)*(n-6)+jj) = reshape(im(ii:ii+6,jj:jj+6), [49,1]);
    end
end
C = P*(P');
[V,D] = eig(C);
alp = V*P;
avgAlpSq = zeros(49,1);
for jj = 1:49
    avgAlpSq(jj) = max(0, sum(alp(:,jj).^2)/N - sigmaSq);
end
alpNew = zeros(size(alp));
for ii = 1:N
    for jj =  1:49
        alpNew(jj, ii) = alp(jj, ii) / (1 + (sigmaSq)/avgAlpSq(jj));
    end
end
newP = (V')*alpNew;
imNew = zeros(size(im));
newPatch = zeros(7,7);
numValues = zeros(size(im));
[m,n] = size(im);
for ii = 1:N
    newPatch = reshape(newP(:,ii),[7,7]);
    r1 = uint16(idivide(uint16(ii), uint16(m-6), 'floor')+1);
    if ((m-6)*(r1-1)==ii)
        r1 = r1-1;
    end
    r2 = uint16(r1+6);
    c1 = uint16(ii-(r1-1)*(m-6));
    c2 = uint16(c1+6);
%     imNew(r1:r2,c1:c2) = imNew(r1:r2,c1:c2).*numValues(r1:r2,c1:c2) + newPatch;
    imNew(r1:r2,c1:c2) = imNew(r1:r2,c1:c2) + newPatch;
    numValues(r1:r2,c1:c2) = numValues(r1:r2,c1:c2) + ones(7,7);
    %imNew(r1:r2,c1:c2) = imNew(r1:r2,c1:c2)./numValues(r1:r2,c1:c2);
end
imNew = imNew./numValues;
figure;
imshow(uint8(imNew));