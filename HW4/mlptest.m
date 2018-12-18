function [z,error_rate] = mlptest(testdata,w,v)
%testdata=load(testdata);
test_t=size(testdata,1);
test_r=testdata(:,end);
test_x=[ones(test_t,1) testdata(:,1:end-1)];
z=w*test_x';
z(z<0)=0;
test_z_plus=[ones(test_t,1) z'];
test_o=test_z_plus*transpose(v);


label=zeros(test_t,1);
for t=1:test_t
    test_y(t,:)=exp(test_o(t,:))/sum(exp(test_o(t,:)));
    [~,idx]=max(test_y(t,:));
    label(t,1)=idx-1;
end
error_rate=sum(label~=test_r)/test_t;
disp(['error rate',num2str(error_rate)]);
z=z';
end