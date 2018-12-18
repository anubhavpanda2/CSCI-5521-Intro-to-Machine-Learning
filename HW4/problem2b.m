traindata=load('optdigits_train.txt');
valdata=load('optdigits_valid.txt');
testdata=load('optdigits_test.txt');
totaldata=[traindata ;valdata];
%totaler=zeros(1,6);

[a,w,v]=mlptrain(traindata,valdata,18,10);
[z,totalerror]=mlptest(totaldata,w,v);
[ eigvaluek1,eigvectork1 ]=myPCA(z, 2);
m=mean(z);
z1=z-m;
totaldataafterPCAtwo=(eigvectork1'*z1')';
coltab = [50/255 153/255 153/255; 
    100/255 204/255 255/255;
    150/255 210/255 190/255;
    200/255 170/255 160/255;
    250/255 150/255 140/255;
    150/255 50/255 130/255;
    130/255 100/255 210/255;
    0/255 150/255 100/255;
    255/255 200/255 00/255;
    110/255 250/255 230/255];
RGB = coltab(totaldata(:,end)+1, :);
pointsize = 8;
figure
totaldataafterPCAtwo(totaldataafterPCAtwo<0)=-log(-totaldataafterPCAtwo(totaldataafterPCAtwo<0));
totaldataafterPCAtwo(totaldataafterPCAtwo>0)=log(totaldataafterPCAtwo(totaldataafterPCAtwo>0));
gscatter(totaldataafterPCAtwo(:,1),totaldataafterPCAtwo(:,2),totaldata(:,end)+1);
%text(totaldataafterPCAtwo(:,1),totaldataafterPCAtwo(:,2),num2str(totaldata(:,end)),'fontsize',3);
[ eigvaluek1,eigvectork1 ]=myPCA(z, 3);
m=mean(z);
z1=z-m;
totaldataafterPCAthree=(eigvectork1'*z1')';
figure
totaldataafterPCAthree(totaldataafterPCAthree<0)=-log(-totaldataafterPCAthree(totaldataafterPCAthree<0));
totaldataafterPCAthree(totaldataafterPCAthree>0)=log(totaldataafterPCAthree(totaldataafterPCAthree>0));
scatter3((totaldataafterPCAthree(:,1)),(totaldataafterPCAthree(:,2)),(totaldataafterPCAthree(:,3)),pointsize,RGB, 'filled');
text((totaldataafterPCAthree(:,1)),(totaldataafterPCAthree(:,2)),(totaldataafterPCAthree(:,3)),num2str(totaldata(:,end)),'fontsize',3);
        