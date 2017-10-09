function YaleFaceRecog(kVec, excludeTop3)
d = 192*168;
n1 = 38;
n2 = 40;
N = n1*n2;
X = zeros(d,N);
n = 0;
trainLabels = string(zeros(1,N));
mean = zeros(d,1);
path = '../../../../CroppedYale/';
drs = struct2cell(dir(strcat(path,'yaleB*')));
for dr = drs(1,:)
    filepath = strcat(path,char(dr),'/*.pgm');
    files = struct2cell(dir(filepath));
    for f = files(1,1:40)
        fullpath = strcat(path,dr,'/',f);
        Img = imread(char(fullpath));
        n = n + 1;
        Img = reshape(Img,[d,1]);
        X(:,n) = Img;
        trainLabels(1,n) = filepath;
        mean = mean + (double(Img)./N);
    end
end
for i = 1:N
    X(:,i) = X(:,i) - mean;
end
% [~,S,V1] = svd(X);
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
    
    for dr = drs(1,:)
        filepath = strcat(path,char(dr),'/*.pgm');
        files = struct2cell(dir(filepath));
        for f = files(1,41:60)
            fullpath = strcat(path,dr,'/',f);
            inpImg = imread(char(fullpath));
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
            if (excludeTop3 == 1 && kk >= 4)
                I1(1) = I1(4);
            end
            %trainLabels(I1(1))
            if(trainLabels(I1(1)) == filepath)
                correct = correct + 1;
            end
        end
    end
    y(ll) = (correct/(38*20))*100;
    ll = ll + 1;
end
plot(kVec,y,'-o');
title('Variation of rate of recognition with k');
xlabel('k');
ylabel('Rate of recognition');
end