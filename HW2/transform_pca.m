function [transformed_data] = transform_pca(data, w)
    m = mean(data);
    z = w'*(data'-m');
    transformed_data = z';
end