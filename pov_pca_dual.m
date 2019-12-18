clear;
load('data/digit.mat');
train_mat = cell2mat(train);
test_mat = cell2mat(test);
train_data = reshape(train_mat, [784,300]);
test_data = reshape(test_mat, [784,10]);

[PC_train, V_train] = pca_dual(train_data);
V_total = sum(V_train);
PoV = zeros(1,length(V_train));
for i = 1:length(V_train)
    PoV(i) = sum(V_train(1:i)) / V_total;
end

figure('Name', 'PoV of PCA-DUAL', 'NumberTitle', 'off');
hold on;
position = find(PoV > 0.9, 1 );
plot((1:length(V_train)), PoV, 'b.-');
plot([position, position],[0, PoV(position)],'--','LineWidth',2);
text(position, PoV(position), ['(',num2str(position),',',num2str(PoV(position)),')']);
grid on;
title('PoV of PCA-DUAL');
xlabel('Number of Eigenvectors');
ylabel('PoV');
hold off;