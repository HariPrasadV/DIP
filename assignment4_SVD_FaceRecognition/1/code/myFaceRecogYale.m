function myFaceRecogYale(k_vals, excludeTop3)

    data_root = '../../data/CroppedYale/';
    dir_list = dir(strcat(data_root, 'yale*'));

    m = 192;
    n = 168;

    % number of subdirs
    Ndirs = 38;
    % number of training images in each subdir 
    Ntrain = 40;
    % number of testing images in each subdir
    Ntest = 20;

    Nxcols = Ndirs * Ntrain;
    Nycols = Ndirs * Ntest;

    X = zeros(m * n, Nxcols);
    Xlabel = zeros(1, Nxcols);
    Y = zeros(m * n, Nycols);
    Ylabel = zeros(1, Nycols);

    index_x = 1;
    index_y = 1;
    for ii = 1:Ndirs
        subdir = strcat(data_root, dir_list(ii).name, '/');
        img_list = dir(strcat(subdir, '*.pgm'));

        for jj = 1:Ntrain
            I = imread(strcat(subdir, img_list(jj).name));
            I = mat2gray(I);
            X(:, index_x) = I(:);
            Xlabel(index_x) = ii;
            index_x = index_x + 1;
        end

        for jj = Ntrain+1:Ntrain+Ntest
            I = imread(strcat(subdir, img_list(jj).name));
            I = mat2gray(I);
            Y(:, index_y) = I(:);
            Ylabel(index_y) = ii;
            index_y = index_y + 1;
        end
    end

    mean_face = mean(X, 2);

    for ii = 1:Nxcols
        X(:, ii) = X(:, ii) - mean_face;
    end

    %%

    L = X' * X;
    [W, D] = eig(L);
    vals = diag(D);
    [~, indices] = sort(vals, 'descend');
    W = W(:, indices);
    
    V = X * W;
    V = normc(V);

    %%

    % k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
    
    nk = size(k_vals, 2);
    recog_rate = zeros(1, nk);

    disp('starting..')

    for ii = 1:nk   
        k = k_vals(ii);
        
        disp(strcat('running for k = ', num2str(k)));

    %     [U, S, ~] = svds(X, k+3);
    %     vals = diag(S);
    %     [~, indices] = sort(vals, 'descend');
    %     U = U(:, indices);
    %     V = normc(U);
    
        if (excludeTop3 == 1)
            Vk_t = V(:, 4:k+3)';
        else
            Vk_t = V(:, 1:k)';
        end
        
        alpha = zeros(k, Nxcols);
        for jj = 1:Nxcols
            alpha(:, jj) = Vk_t * X(:, jj);
        end

        correct = 0;
        for jj = 1:Nycols
            z = Y(:, jj);
            z = z - mean_face;
            b = Vk_t * z;

            IDX = knnsearch(alpha', [b]');
            correct = correct + (Ylabel(jj) == Xlabel(IDX));
        end
        recog_rate(ii) = (correct / Nycols);
    end
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    plot(k_vals, recog_rate, '-o');
    if (excludeTop3 == 1)
        title('(Yale) Variation of rate of recognition with k (excluding top 3 eigenfaces)');
    else
        title('(Yale) Variation of rate of recognition with k ');
    end
    xlabel('k');
    ylabel('Rate of recognition');
    
end
