
data_root = '../../data/att_faces/';
dir_list = dir(strcat(data_root, 's*'));

m = 112;
n = 92;
X = zeros(m * n, 0);
Y = zeros(m * n, 0);

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
    end
    
    for jj = Ntrain+1:Ntrain+Ntest
        I = imread(strcat(subdir, img_list(jj).name));
        I = mat2gray(I);
        Y = [Y, I(:)];
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


