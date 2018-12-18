training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
n_test = size(test_data,1);
d_test = size(test_data,2);
n_train = size(training_data,1);
d_train = size(training_data,2);
c = test_data(:,d_test);
y_train = training_data(:,d_train);

%training_data_cleaned = training_data;
%for i = 1:d_train-1
%    if all(training_data(:,i)==0)
%        training_data_cleaned(:,i)=[];
%        test_data(:,i)=[];
%    end
%end
    
%training_data = training_data_cleaned;
%d_train = size(training_data,2);
%d_test = size(test_data,2);
    
L = [2,4,9];
k = [1,3,5];

for i = L
    [Vs, Ds] = myLDA(training_data, i);
    w = Vs;
    z_train = transform_lda(training_data(:,1:d_train-1), w);
    z_test = transform_lda(test_data(:,1:d_test-1), w);
    % Add back the dependent variable or class column
    z_train = [z_train, y_train];
    z_test = [z_test, c];
    for j = k
        cpred = myKNN(z_train, z_test, j);
        err = sum(~(c==cpred))/n_test;
        fprintf("error ratio for L = %d  and  k = %d  is %f \n", i, j, err);
    end
end