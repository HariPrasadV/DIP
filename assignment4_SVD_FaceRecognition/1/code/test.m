%%
data_root = '../../data/att_faces/';
dir_list = dir(strcat(data_root, 's*'));

m = 112;
n = 92;
X = zeros(m * n, 0);
Xlabel = zeros(0, 0);
Y = zeros(m * n, 0);
Ylabel = zeros(0, 0);

% number of subdirs
Ndirs = 32;
% number of training images in each subdir 
Ntrain = 6;
% number of testing images in each subdir
Ntest = 4;

for ii = 1:Ndirs
    subdir = strcat(data_root, dir_list(ii).name, '/');
    img_list = dir(strcat(subdir, '*.pgm'));
    for jj = 1:Ntrain
        I = imread(strcat(subdir, img_list(jj).name));
        I = mat2gray(I);
        X = [X, I(:)];
        Xlabel = [Xlabel, ii];
    end
    
    for jj = Ntrain+1:Ntrain+Ntest
        I = imread(strcat(subdir, img_list(jj).name));
        I = mat2gray(I);
        Y = [Y, I(:)];
        Ylabel = [Ylabel, ii];
    end
end

mean_face = mean(X, 2);

% Xi = Xi - mean
Ncols = Ndirs * Ntrain;
for ii = 1:Ncols
    X(:, ii) = X(:, ii) - mean_face;
end


L = X' * X;
[W, D] = eig(L);
vals = diag(D);
[~, indices] = sort(vals, 'descend');
W = W(:, indices);

V = X * W;

%%
k_vals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
nk = size(k_vals, 2);

for ii = 1:1
    k = k_vals(ii);
    Vk_t = V(:, 1:k)';
    
    alpha = zeros(k, 0);
    for jj = 1:Ncols
        alpha = [alpha, Vk_t * X(:, jj)];
    end
    
    Nycols = Ndirs * Ntest;
    for jj = 1:Nycols
        z = Y(:, jj);
        z = z - mean_face;
        b = Vk_t * z;
        
        IDX = knnsearch(alpha', [b]);
        disp(Ylabel(jj) - Xlabel(IDX));
    end
end









