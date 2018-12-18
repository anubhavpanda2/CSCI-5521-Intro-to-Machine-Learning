training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
n_test = size(test_data,1);
d_test = size(test_data,2);
c = test_data(:,d_test);
y_train = training_data(:,size(training_data,2));
x_train = training_data(:,1:size(training_data,2)-1);
x_test = test_data(:,1:d_test-1);

[Vs, Ds] = myPCA(x_train, size(x_train,2));
pov = Ds(1);
for i=2:length(Ds)
    pov(i) = pov(i-1) + Ds(i);
end
pov = pov./sum(Ds);
plot(1:length(pov), pov, '-*');
xlabel('Eigen Vectors');
ylabel('Prop. of Variance Explained');
k = length(pov);
for i=1:length(Ds)
    if pov(i)>=0.9
        k = i;
        break;
    end
end
fprintf("K value is %d \n",k);
%[Vs, Ds] = myPCA(x_train, 21);
%[coeff,score,latent] = pca(x_train);
w = Vs(:,1:k);
z_train = transform_pca(x_train, w);
z_test = transform_pca(x_test, w);

% Add back the dependent variable or class column
z_train = [z_train, y_train];
z_test = [z_test, c];
k = [1,3,5,7];
for i = k
    cpred = myKNN(z_train, z_test, i);
    err = sum(~(c==cpred))/n_test;
    fprintf("error ratio for k = %d is %f \n", i, err);
end
