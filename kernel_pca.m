clear;
load('data/digit.mat');
train_data = reshape(cell2mat(train), [784,300]);
test_data = reshape(cell2mat(test), [784,10]);

[m,n]=size(train_data);
mn = mean(train_data, 2);
train_cent = train_data - repmat(mn,1,n);
K = zeros(n,n); 
for i = 1:n
    for j = 1:n 
        K(i, j) = kernel(train_cent(:,i), train_cent(:,j), 3, 9); 
    end 
end
[M,N] = size(K);
MN = mean(K, 2);
K = K - repmat(MN,1,N);

[PC_K, V] = eig(K);
V = diag(V);
[junk, rindices] = sort(V, 'descend');
V = V(rindices);
PC_K = PC_K(:,rindices);

V_total = sum(V);
PoV = zeros(1,length(V));
for i = 1:length(V)
    PoV(i) = sum(V(1:i)) / V_total;
end
dimension = find(PoV > 0.9, 1);
PC = PC_K(:,1:dimension);

[m2,n2] = size(test_data);
test_cent = test_data - repmat(mn,1,n2);
K_test = zeros(n,n2);
for i = 1:n
    for j = 1:n2
        % 3 and 9 are the parameters of polynomial kernel function
        K_test(i,j) = kernel(train_cent(:,i), test_cent(:,j), 3, 9);
    end
end
test_low = PC' * K_test;
disp(test_low);

figure('Name', 'PoV of KPCA', 'NumberTitle', 'off');
hold on;
position = find(PoV > 0.9, 1);
plot((1:length(V)), PoV, 'b.-');
plot([position, position],[0, PoV(position)],'--','LineWidth',2);
text(position, PoV(position), ['(',num2str(position),',',num2str(PoV(position)),')']);
grid on;
title('PoV of KPCA');
xlabel('Number of Eigenvectors');
ylabel('PoV');
hold off;
