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
diff = test_data - test_recon;
distance = sum(diff.^2);

test_reimage = reshape(test_recon, [28,28,10]);
figure
for i=1:10
    subplot(2,5,i)
    display_digit(test_reimage(:,:,i))
    title(['error = ',num2str(distance(i))])
end
suptitle('Reconstructed images and reconstruction errors')





