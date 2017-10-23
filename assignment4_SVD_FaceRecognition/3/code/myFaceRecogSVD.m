function myFaceRecogSVD(kVec)
    % kVec = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
    d = 112*92;
    n1 = 32;
    n2 = 6;
    N = n1*n2;
    X = zeros(d,N);
    n = 0;
    mean = zeros(d,1);
    for j = 1:n1
        for i = 1:n2
            Img = imread(strcat('../../data/att_faces/s',int2str(j),'/',int2str(i),'.pgm'));
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

    y = zeros(size(kVec));
    ll = 1;
    max_diffQ = -1;
    max_diffM = -1;
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
                inpImg = imread(strcat('../../data/att_faces/s',int2str(pp),'/',int2str(qq),'.pgm'));
                %imshow(Img);
                inpImg = double(reshape(inpImg,[d,1]));
                inpImg = inpImg - mean;

                Coeff = (topK')*inpImg;
                SqDiff = zeros(1,N);
                for i = 1:N
                    SqDiff(1,i) = norm(Alp(:,i) - Coeff);
                end
                [Q,I1] = sort(SqDiff);
                if (max_diffQ == -1)
                    max_diffQ = Q(1);
                    max_diffM = norm(inpImg);
                end
                if (Q(1) > max_diffQ)
                    max_diffQ = Q(1);
                end
                if (norm(inpImg) > max_diffM)
                    max_diffM = norm(inpImg);
                end
                if(uint8(I1(1))/6 == pp)
                    correct = correct + 1;
                end
            end
        end
        y(ll) = (correct/(32*4))*100;
        ll = ll + 1;
    end
    max_diffQ
    max_diffM
    figure;
    plot(kVec,y,'-o');
    title('Variation of rate of recognition with k');
    xlabel('k');
    ylabel('Rate of recognition');


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
        falsePositive = 0;
        for pp = 33:40
            for qq = 7:10
                inpImg = imread(strcat('../../data/att_faces/s',int2str(pp),'/',int2str(qq),'.pgm'));
                %imshow(Img);
                inpImg = double(reshape(inpImg,[d,1]));
                inpImg = inpImg - mean;

                Coeff = (topK')*inpImg;
                SqDiff = zeros(1,N);
                for i = 1:N
                    SqDiff(1,i) = norm(Alp(:,i) - Coeff);
                end
                [Q,I1] = sort(SqDiff);
                if(Q(1) < max_diffQ && norm(inpImg) < max_diffM)
                    falsePositive = falsePositive + 1;
                end
            end
        end
        y(ll) = (falsePositive/(8*4))*100;
        ll = ll + 1;
    end
    figure;
    plot(kVec,y,'-o');
    title('Variation of rate of false positive with k');
    xlabel('k');
    ylabel('Rate of recognition');



    y1 = zeros(size(kVec));
    y2 = zeros(size(kVec));
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
        falsePositive = 0;
        falseNegative = 0;

        for pp = 1:32
            for qq = 1:6
                inpImg = imread(strcat('../../data/att_faces/s',int2str(pp),'/',int2str(qq),'.pgm'));
                %imshow(Img);
                inpImg = double(reshape(inpImg,[d,1]));
                inpImg = inpImg - mean;

                Coeff = (topK')*inpImg;
                SqDiff = zeros(1,N);
                for i = 1:N
                    SqDiff(1,i) = norm(Alp(:,i) - Coeff);
                end
                [Q,I1] = sort(SqDiff);
                if(Q(1) < max_diffQ && norm(inpImg) < max_diffM)
                    if(uint8(I1(1))/6 ~= pp)
                        falsePositive = falsePositive + 1;
                    end
                else
                    if(uint8(I1(1))/6 == pp)
                        falseNegative = falseNegative + 1;
                    end
                end
            end
        end
        y1(ll) = (falsePositive/(32*6))*100;
        y2(ll) = (falseNegative/(32*6))*100;
        ll = ll + 1;
    end
    figure;
    plot(kVec,y1,'-o');
    title('Variation of rate of false positive with k');
    xlabel('k');
    ylabel('Rate of recognition');
    figure;
    plot(kVec,y2,'-o');
    title('Variation of rate of false negative with k');
    xlabel('k');
    ylabel('Rate of recognition');
end