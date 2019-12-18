clear;
load('data/digit.mat');
train_mat = cell2mat(train);
test_mat = cell2mat(test);
train_data = reshape(train_mat, [784,300]);
test_data = reshape(test_mat, [784,10]);
t = zeros(10,2);

for i = 1:10
    tic
    [PC_train1, V_train1] = pca(train_data);
    t1 = toc;
    
    tic
    [PC_train2, V_train2] = pca_dual(train_data);
    t2 = toc;
    t(i,1) = t1;
    t(i,2) = t2;
end

figure;
set(gcf,'position',[200 300 550 420]);
hold on;
bar(t);
title('Time Cost');
xlabel('Time');
ylabel('Time Cost(sec)');
legend('PCA','PCA-DUAL');
hold off;


V_total1 = sum(V_train1);
PoV = zeros(1,length(V_train1));
for i = 1:length(V_train1)
    PoV(i) = sum(V_train1(1:i)) / V_total1;
end

figure('Name', 'PoV of PCA', 'NumberTitle', 'off');
set(gcf,'position',[100 50 550 420]);
hold on;
position = find(PoV > 0.9, 1);
plot((1:length(V_train1)), PoV, 'b.-');
plot([position, position],[0, PoV(position)],'--','LineWidth',2);
text(position, PoV(position), ['(',num2str(position),',',num2str(PoV(position)),')']);
grid on;
title('PoV of PCA');
xlabel('Number of Eigenvectors');
ylabel('PoV');
hold off;

V_total2 = sum(V_train2);
PoV = zeros(1,length(V_train2));
for i = 1:length(V_train2)
    PoV(i) = sum(V_train2(1:i)) / V_total2;
end

figure('Name', 'PoV of PCA-DUAL', 'NumberTitle', 'off');
set(gcf,'position',[400 50 550 420]);
hold on;
position = find(PoV > 0.9, 1 );
plot((1:length(V_train2)), PoV, 'b.-');
plot([position, position],[0, PoV(position)],'--','LineWidth',2);
text(position, PoV(position), ['(',num2str(position),',',num2str(PoV(position)),')']);
grid on;
title('PoV of PCA-DUAL');
xlabel('Number of Eigenvectors');
ylabel('PoV');
hold off;
