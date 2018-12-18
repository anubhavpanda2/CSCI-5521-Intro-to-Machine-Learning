traindata=load('optdigits_train.txt');
valdata=load('optdigits_valid.txt');
testdata=load('optdigits_test.txt');
valer=zeros(1,6);
trainer=zeros(1,6);
tester=zeros(1,6);
k=1;
for i=3:3:18
    [z,w,v]=mlptrain(traindata,valdata,i,10);
    [~,valer(k)]=mlptest(valdata,w,v);
    [~,trainer(k)]=mlptest(traindata,w,v);
    [~,tester(k)]=mlptest(testdata,w,v);
    k=k+1;
end
i=3:3:18;
plot(i,valer);
hold on;
plot(i,trainer);
disp(tester);