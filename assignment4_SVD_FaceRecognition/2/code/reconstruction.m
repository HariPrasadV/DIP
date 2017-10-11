function reconstruction(kVec)
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

    %% top-25 eigenfaces

    figure('units','normalized','outerposition',[0 0 1 1])
    suptitle('top 25 eigenfaces');
    set(findall(gcf,'-property','FontSize'),'FontSize',20)
    for ii = 1:25
        subplot(5, 5, ii);
        imshow(mat2gray(reshape(V(:, ii),[m, n])));
        title(strcat('', num2str(ii)));
    end

    %% reconstruct image of one person

    test_image = imread(strcat(data_root, 'yaleB01/yaleB01_P00A+000E+00.pgm'));
    test_image = mat2gray(test_image);

    showImg(test_image, 'original image');

    test_index = 1;

    % kVec = [2, 10, 20, 50, 75, 100, 125, 150, 175];
    for kk = kVec

        % extract top k eigen faces
        Vk = V(:, 1:kk);

        % compute eigen co-efficients of test_image
        alpha = Vk' * X(:, test_index);

        % reconstruct image using eigen-coefficients
        recImg = mean_face + Vk * alpha;

        showImg(mat2gray(reshape(recImg, [m, n])), ... 
            strcat('reconstructed using top k=', num2str(kk), ' eigenfaces'));
    end
end