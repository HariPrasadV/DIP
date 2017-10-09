function myFaceRecogSVD(kVec)
d = 112*92;
n1 = 32;
n2 = 6;
N = n1*n2;
X = zeros(d,N);
n = 0;
mean = zeros(d,1);
for j = 1:n1
    for i = 1:n2
        Img = imread(strcat('../../../../att_faces/s',int2str(j),'/',int2str(i),'.pgm'));
        %imshow(Img);
        n = n + 1;
        Img = reshape(Img,[d,1]);
        X(:,n) = Img;
        mean = mean + (double(Img)./N);
    end
end
for i = 1:N
    X(:,i) = X(:,i) - mean;
end
% [~,S,V1] = svds(X);
% V = X*V1;
% A = diag(S);
% [~,I] = sort(A,'descend');
% Vreq = zeros(d,N-1);
% for i = 1:N-1
%     Vreq(:,i) = V(:,I(i))./norm(V(:,I(i)));
% end
% m = 255.0/max(max(Vreq));
% Vreq = Vreq.*m;
%imshow(reshape(uint8(Vreq(:,4)),[112,92]));

y = zeros(size(kVec));
ll = 1;
for kk = kVec
    [U,S,V1] = svds(X,kk);
     topK = zeros(d,kk);
     for i = 1:kk
         topK(:,i) = U(:,i)./norm(U(:,i));
     end
    m = 255.0/max(max(topK));
    topK = topK.*m;
    
    Alp = (topK')*X;
    correct = 0;
    for pp = 1:32
        for qq = 7:10
            inpImg = imread(strcat('../../../../att_faces/s',int2str(pp),'/',int2str(qq),'.pgm'));
            %imshow(Img);
            inpImg = double(reshape(inpImg,[d,1]));
            inpImg = inpImg - mean;
            
            Coeff = (topK')*inpImg;
            SqDiff = zeros(1,N);
            for i = 1:N
                SqDiff(1,i) = norm(Alp(:,i) - Coeff);
            end
            [Q,I1] = sort(SqDiff);
            %Q(1)
            if(uint8(I1(1))/6 == pp)
                correct = correct + 1;
            end
        end
    end
    y(ll) = (correct/(32*4))*100;
    ll = ll + 1;
end
plot(kVec,y,'-o');
title('Variation of rate of recognition with k');
xlabel('k');
ylabel('Rate of recognition');
end