data_root = '../../data/att_faces/';
dir_list = dir(strcat(data_root, 's*'));

m = 112;
n = 92;
X = zeros(m * n, 0);

% number of subdirs
Ndirs = 32;
% number of images in each subdir 
Nimgs = 6;

for ii = 1:Ndirs
    subdir = strcat(data_root, dir_list(ii).name, '/');
    img_list = dir(strcat(subdir, '*.pgm'));
    for jj = 1:Nimgs
        I = imread(strcat(subdir, img_list(jj).name));
        I = mat2gray(I);
        X = [X, I(:)];
    end
end

mean_face = mean(X, 2);

% Xi = Xi - mean
Ncols = Ndirs * Nimgs;
for ii = 1:Ncols
    X(:, ii) = X(:, ii) - mean_face;
end


L = X' * X;
[W, D] = eig(L);
vals = diag(D);
[~, indices] = sort(vals, 'descend');
W = W(:, indices);

V = X * W;
