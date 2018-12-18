function [transformed_data] = back_transform_pca(data, w, mu)
    z = (w*data') + mu';
    transformed_data = z';
end