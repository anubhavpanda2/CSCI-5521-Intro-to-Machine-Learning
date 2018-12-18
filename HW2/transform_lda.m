function [transformed_data] = transform_lda(data, w)
    z = w'*data';
    transformed_data = z';
end