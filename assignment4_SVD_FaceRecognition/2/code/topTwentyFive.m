function topTwentyFive()
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

kk = 25;
[U,S,V1] = svds(X,kk);
topK = zeros(d,kk);
for i = 1:kk
    topK(:,i) = U(:,i)./norm(U(:,i));
end
m = 255.0/max(max(topK));
topK = topK.*m;
for i = 1:kk
    subplot(5,5,i);
    imshow(reshape(uint8(topK(:,i)),[192,168]));
end
saveas(gcf,'top25.png');
end