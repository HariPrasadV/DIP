%% MyMainScript

tic;
%% Your code here
x = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
y = zeros(size(x));
i = 1;
for k = x
    y(i) = myFaceRecog(k);
    i = i + 1;
end
plot(x,y,'-o');
title('Variation of rate of recognition with k');
xlabel('k');
ylabel('Rate of recognition');
toc;
