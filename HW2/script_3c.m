training_data = load('face_train_data_960.txt');
%training_data = training_data(1:5,:);
y_train = training_data(:,size(training_data,2));
x_train = training_data(:,1:size(training_data,2)-1);
mu = mean(x_train);
k = [10, 50, 100];

l = 1;
for i = 1:length(k)
    [Vs, Ds] = myPCA(x_train, k(i));
    w = Vs;
    z_train = transform_pca(x_train, w);
    x_train_reconstructed = back_transform_pca(z_train, w, mu);
    for j = 1:5
        subplot(3,5,l);
        l = l + 1;
        imagesc(reshape(x_train_reconstructed(j,:),32,30)');
        title("Image: " + j + "; k=" + k(i));
    end
end
