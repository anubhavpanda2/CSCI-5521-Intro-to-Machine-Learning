training_data = 'training_data.txt';
test_data = 'test_data.txt';
[pc1, pc2, m1, m2, s1, s2] = MultiGaussian(training_data, test_data, 1);
[pc1, pc2, m1, m2, s1, s2] = MultiGaussian(training_data, test_data, 2);
[pc1, pc2, m1, m2, s1, s2] = MultiGaussian(training_data, test_data, 3);

