%M = 47
clear;
load('data/digit.mat');
train_mat = cell2mat(train);
test_mat = cell2mat(test);
train_data = reshape(train_mat, [784,300]);
test_data = reshape(test_mat, [784,10]);

[M,N] = size(test_data);
mn = mean(train_data, 2);
test_cent = test_data - repmat(mn,1,N);
[PC_train, V_train] = pca_dual(train_data);
Basis = PC_train(:, 1:47);
test_low = Basis.' * test_cent;
disp(test_low);