function [z,w,v] = mlptrain(traindata,valdata,m,k)
%k=10;
%m=18;
%d=64;
%traindata=load(traindata);
%valdata=load(valdata);
%testdata=load('optdigits_test.txt');
ip=traindata(:,1:end-1);
d=size(ip,2);
v=random('unif',-0.01,0.01,[k,m+1]);
w=random('unif', -0.01,0.01,[m,d+1]);
T=size(ip,1);
z=zeros(T,m);
ip=[ones(T,1) ip];
delta_v=zeros(k,m+1);
delta_w=zeros(m,d+1);
ita=0.001;
err=5;
prev_err=-1;
r=zeros(T,k);
for t=drange(1:T)
    r(t,traindata(t,end)+1)=1;
end
 i=0;
while abs(err-prev_err)> 0.01
     prev_err=err;
    err=0;
   
    for t=randperm(T)
        z_row=w*ip(t,:)';
        z_row(z_row< 0) = 0;
        z_row=[1 z_row'];
        i=i+1;
        if(i>12000)
            ita=0.00001;
        elseif(i>120000)
            ita=0.000001;
        end
       
        o=z_row*transpose(v);
        y=exp(o)/sum(exp(o));
        delta_v=ita*transpose((r(t,:)-y))*z_row;
        delta_w=ita*transpose(((r(t,:)-y)*v(:,2:end)))*ip(t,:);
        delta_w(w<=0)=0;
        v=v+delta_v;
        w=w+delta_w;
        err=err-r(t,:)*transpose(log(y));
        z(t,:)=z_row(2:end);
        
    end
end
 disp(i);
testdata=valdata;
%testdata=traindata;
test_t=size(testdata,1);
test_r=testdata(:,end);
test_x=[ones(test_t,1) testdata(:,1:end-1)];
test_z=w*test_x';
test_z(test_z<0)=0;
test_z_plus=[ones(test_t,1) test_z'];
test_o=test_z_plus*transpose(v);


label=zeros(test_t,1);
for t=1:test_t
    test_y(t,:)=exp(test_o(t,:))/sum(exp(test_o(t,:)));
    [~,idx]=max(test_y(t,:));
    label(t,1)=idx-1;
end
error_rate=sum(label~=test_r)/test_t
disp(['validation error rate',num2str(error_rate)]);
%testdata=valdata;
testdata=traindata;
test_t=size(testdata,1);
test_r=testdata(:,end);
test_x=[ones(test_t,1) testdata(:,1:end-1)];
test_z=w*test_x';
test_z(test_z<0)=0;
test_z_plus=[ones(test_t,1) test_z'];
test_o=test_z_plus*transpose(v);


label=zeros(test_t,1);
for t=1:test_t
    test_y(t,:)=exp(test_o(t,:))/sum(exp(test_o(t,:)));
    [~,idx]=max(test_y(t,:));
    label(t,1)=idx-1;
end
error_rate=sum(label~=test_r)/test_t;
disp(['train error rate',num2str(error_rate)]);

end
%end