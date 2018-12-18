training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
combined_data = [training_data; test_data];
n = size(combined_data,1);
d = size(combined_data,2);
c = combined_data(:,d);

[Vs, Ds] = myLDA(training_data, 2);
w = Vs;
z = transform_lda(combined_data(:,1:d-1), w);

vcolour = [0.8,0.3,0; 0,0,1; 0,1,0; 0.9,1,0.3; 1,0,0; 1,0.1,0.5; 1,0.3,0; 1,1,1; 0.4,0.1,0.9; 0.6,0.2,0.1];
scatter(z(:,1),z(:,2),10,vcolour(c+1),'filled');
text(z(:,1),z(:,2),num2str(c));
xlabel('ax1');
ylabel('ax2');
title('LDA projections');