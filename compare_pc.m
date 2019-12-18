clear;
load('data/iris.mat');
config = ["ro", "go", "bo"];
config_face = ["r", "g", "b"];
%[PC, V] = pca(X);
[PC, V] = pca_dual(X);
[M,N] = size(X);
mn = mean(X,2);
X_centralized = X - repmat(mn,1,N);

figure('Name', 'PC1-PC2', 'NumberTitle', 'off');
set(gcf,'position',[200 300 550 420]);
PC_new = PC(:, 1:2);
X_new = PC_new.' * X_centralized;
hold on;
for i = 1:3
    pos = find(y == i);
    plot(X_new(1, pos), X_new(2, pos), config(i), 'MarkerFaceColor', config_face(i));
end
title('PC1-PC2');
xlabel('PC1');
ylabel('PC2');
legend('Class 1','Class 2','Class 3');
hold off;

figure('Name', 'PC1-PC3', 'NumberTitle', 'off');
set(gcf,'position',[100 50 550 420]);
PC_new = PC(:, [1,3]);
X_new = PC_new.' * X_centralized;
hold on;
for i = 1:3
    pos = find(y == i);
    plot(X_new(1, pos), X_new(2, pos), config(i), 'MarkerFaceColor', config_face(i));
end
title('PC1-PC3');
xlabel('PC1');
ylabel('PC3');
legend('Class 1','Class 2','Class 3');
hold off;

figure('Name', 'PC2-PC3', 'NumberTitle', 'off');
set(gcf,'position',[400 50 550 420]);
PC_new = PC(:, 2:3);
X_new = PC_new.' * X_centralized;
hold on;
for i = 1:3
    pos = find(y == i);
    plot(X_new(1, pos), X_new(2, pos), config(i), 'MarkerFaceColor', config_face(i));
end
title('PC2-PC3');
xlabel('PC2');
ylabel('PC3');
legend('Class 1','Class 2','Class 3');
hold off;