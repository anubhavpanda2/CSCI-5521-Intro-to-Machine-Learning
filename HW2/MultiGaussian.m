function [pc1, pc2, m1, m2, s1, s2] = MultiGaussian(training_data, testing_data, Model)
    training_data = load(training_data);
    test_data = load(testing_data);

    train_size = size(training_data);
    n_train = train_size(1);
    d_train = train_size(2);
    y_train = training_data(:,d_train);
    x_train = training_data(:,1:d_train-1);
    c = unique(y_train);
    c1 = c(1);
    c2 = c(2);
    x1 = x_train(y_train==c1,:);
    x2 = x_train(y_train==c2,:);
    m1 = mean(x1);
    m2 = mean(x2);
    pc1 = sum(y_train==c1)/n_train;
    pc2 = 1-pc1;
    s1 = cov(x1);
    s2 = cov(x2);
    if Model == 2
        s1 = pc1*s1 + pc2*s2;
        s2 = s1;
    elseif Model == 3
            alpha1 = 0;
            alpha2 = 0;
            for i=1:n_train
                if y_train(i) == c1
                    alpha1 = alpha1 + ((x_train(i,:)'-m1')'*(x_train(i,:)'-m1'));
                elseif y_train(i) == c2
                        alpha2 = alpha2 + ((x_train(i,:)'-m2')'*(x_train(i,:)'-m2'));
                end
            end
            alpha1 = alpha1/((d_train-1)*sum(y_train==c1));
            alpha2 = alpha2/((d_train-1)*sum(y_train==c2));
            s1 = alpha1;
            s2 = alpha2;
    end
    printMultiGuassianStatistics(test_data, Model, pc1, pc2, m1, m2, s1, s2);
end