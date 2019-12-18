%M = 47
clear;
load('data/digit.mat');
train_mat = cell2mat(train);
test_mat = cell2mat(test);
train_data = reshape(train_mat, [784,300]);
test_data = reshape(test_mat, [784,10]);

[M,N] = size(test_data);
mn = mean(train_data, 2);
mn_mat = repmat(mn,1,N);
test_cent = test_data - mn_mat;
[PC_train, V_train] = pca_dual(train_data);
Basis = PC_train(:, 1:47);
test_low = Basis.' * test_cent;

test_recon = Basis * test_low + mn_mat;
test_recon = reshape(test_recon, [28,28,10]);

figure
set(gcf,'position',[100 50 550 420]);
hold on;
for i=1:10
    subplot(2,5,i)
    display_digit(test{i})
    title(['No.',num2str(i)])
end
suptitle('Original Images')
hold off;

figure
set(gcf,'position',[400 50 550 420]);
hold on;
for i=1:10
    subplot(2,5,i)
    display_digit(test_recon(:,:,i))
    title(['No.',num2str(i)])
end
suptitle('Reconstructed Images')
hold off;




