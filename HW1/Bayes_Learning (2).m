function [pofxc1,pofxc2,pc1,pc2]= Bayes_Learning(TD,TV)
%TD = dlmread('SPECT_train.txt');
[rows,cols]=size(TD);
noof1=0;
noof2=0;
for row = 1:rows
    if TD(row,23)==1
        noof1 =noof1+1;
    else
        noof2 =noof2+1;
    end
end
pofxc1=zeros(1,22);
pofxc2=zeros(1,22);
for col = 1:cols-1
    nof1c=0;
    nof2c=0;
    for row = 1:rows
        if TD(row,col)==0 && TD(row,23)==1
            nof1c= nof1c+1;
        elseif TD(row,col)==0 && TD(row,23)==2
            nof2c=nof2c+1;
        end
    end
    pofxc1(col)=(nof1c*1.0/noof1);
    pofxc2(col)=(nof2c*1.0/noof2);
end
err=0;
sig=0;
minerr=intmax;
%TV = dlmread('SPECT_valid.txt');
disp(['     sigma      PC1      PC2      error']);
for sigma=-5:1:5
    pofc1=1/(1+exp(-1*sigma));
    pofc2=1-pofc1;
    err=0;
   
    for row=1:rows
         c1=pofc1;
    c2=pofc2;
        for col=1:cols-1
            c=0;
            tempvaluex1=power(pofxc1(col),1-TV(row,col))*power(1-pofxc1(col),TV(row,col));
            tempvaluex2=power(pofxc2(col),1-TV(row,col))*power(1-pofxc2(col),TV(row,col));
            if tempvaluex1==0
                tempvaluex1=10^-10;
            end
            if tempvaluex2==0
                tempvaluex2=10^-10;
            end
            if c1*tempvaluex1<power(10,-10)
            c1=power(10,-10);
            else
                c1=c1*tempvaluex1;
            end
%             if c2*tempvaluex2~=0
%             c2=c2*tempvaluex2;
%             end
            if c2*tempvaluex2<power(10,-10)
            c2=power(10,-10);
            else
                c2=c2*tempvaluex2;
            end
        end
        if c1>c2
                c=1;
            else
                c=2;
            end
            if c~=TV(row,23)
                err=err+1;
            end
    end
    err=err/89;
%    sprintf(sigma,err);
%disp(['P(C1) is equal to ',sigma,'errorrate',err]);
disp([sigma,pofc1,pofc2,err*100]);
    if minerr>err
        minerr=err;
        sig=sigma;
        pc1=pofc1;
        pc2=pofc2;
    end
   % minerr
    %sig
end