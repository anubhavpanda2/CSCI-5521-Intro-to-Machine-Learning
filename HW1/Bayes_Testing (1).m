function f=Bayes_Testing(TestData,p1,p2,pc1,pc2)
[rows,cols]=size(TestData);
err=0;
for row=1:rows
    pofxc1=pc1;
    pofxc2=pc2;
    c=0;
    for col=1:cols-1
       c1= power(p1(col),1-TestData(row,col))*power(1-p1(col),TestData(row,col));
       c2= power(p2(col),1-TestData(row,col))*power(1-p2(col),TestData(row,col));
       if(c1==0)
           c1=10^-10;
       end
       if(c2==0)
           c2=10^-10;
       end
       pofxc1=pofxc1*c1;
       pofxc2=pofxc2*c2;
    end
    if(pofxc1>pofxc2)
        c=1;
    else
        c=2;
    end
    if c~=TestData(row,23)
        err=err+1;
    end
end
sprintf('Error rate in percentage: %f', err*100/row)