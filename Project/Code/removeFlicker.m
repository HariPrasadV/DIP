tic;
m = 240;
n = 320;
ch = 3;
fno = 8;
first = 0;
k = 7;
sigma = 3;
X = zeros(2*k+1,m,n,ch);
V = VideoReader('../Videos/4.avi');
VO = VideoWriter('../Videos/res4.avi');
VO.FrameRate = 15;
open(VO);
i = 0;
frame = zeros(m,n,ch);
while hasFrame(V)
    i = i+1;
    if (i < fno-k)
        readFrame(V);
    elseif (i == fno-k)
        flag = 1;
        for j=0:2*k
%           X(j+1,:,:,:) = imread(strcat('../Data4/',int2str(i-k+j),'.png'));
            X(j+1,:,:,:) = readFrame(V);
        end
    else
        X(1:2*k,:,:,:) = X(2:2*k+1,:,:,:);
        X(2*k+1,:,:,:) = readFrame(V);
    end
    
    if (i >= fno-k)
        %figure
%         subplot(2,2,1);
        im = reshape(X(k+1,:,:,:),[m,n,ch]);
%         imshow(uint8(im));
        
        Z = median(X);
        imed = zeros(m,n,ch);
        imed(:,:,:) = Z(1,:,:,:);
%         subplot(2,2,2);
%         imshow(uint8(imed));
        
        IM = log(im+1);
        IMED = log(imed+1);
        
        D = IM - IMED;
        g = fspecial('gaussian',[3*sigma,3*sigma],sigma);
        d = exp(imfilter(D,g));
%         c1 = conv2(D(:,:,1),g,'same');
%         c2 = conv2(D(:,:,2),g,'same');
%         c3 = conv2(D(:,:,3),g,'same');
%         c = zeros(size(D));
%         c(:,:,1) = c1;
%         c(:,:,2) = c2;
%         c(:,:,3) = c3;
%         
%         d = exp(c);
        
        Y = im./d;
%         subplot(2,2,3);
%         imshow(uint8(Y));
        writeVideo(VO,uint8(Y));
        if (i==270*15)
            break;
        end
    end
end
close(VO);
toc;