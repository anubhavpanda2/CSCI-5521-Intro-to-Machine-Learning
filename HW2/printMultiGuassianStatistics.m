function [] = printMultiGuassianStatistics(test_data, Model, pc1, pc2, m1, m2, s1, s2)
    fprintf("Printing Statistics for Model %d :- \n \n", Model);
    fprintf("pc1 =%f\n", pc1);
    fprintf("pc2 =%f\n", pc2);
    fprintf("m1 = \n");
    fprintf([repmat('%f   ',1,size(m1,2)) '\n'],m1);
    fprintf("m2 = \n");
    fprintf([repmat('%f   ',1,size(m2,2)) '\n'],m2);
    if Model == 3
        fprintf("alpha1 =%f\n", s1);
        fprintf("alpha2 =%f\n", s2);
    else
        fprintf("s1 = \n");
        fprintf([repmat('%f   ',1,size(s1,2)) '\n'],s1);
        fprintf("s2 = \n");
        fprintf([repmat('%f   ',1,size(s2,2)) '\n'],s2);
    end
    
    s = size(test_data);
    n = s(1);
    d = s(2);
    g1 = repelem(0,n);
    g2 = repelem(0,n);
    c = test_data(:,d);
    %disp(c);
    cpred = repelem(0,n); 
    vsum = 0;
    x = test_data(:,1:d-1);
    
    for i=1:n
        if Model==1 | Model==2
            g1(i) = (-0.5*log(det(s1))) + (-0.5*(x(i,:)'-m1')'*inv(s1)*(x(i,:)'-m1')) + log(pc1);
            g2(i) = (-0.5*log(det(s2))) + (-0.5*(x(i,:)'-m2')'*inv(s2)*(x(i,:)'-m2')) + log(pc2);
        else
            s1 = s1*eye(d-1);
            s2 = s2*eye(d-1);
            g1(i) = (-0.5*log(det(s1))) + (-0.5*(x(i,:)'-m1')'*inv(s1)*(x(i,:)'-m1')) + log(pc1);
            g2(i) = (-0.5*log(det(s2))) + (-0.5*(x(i,:)'-m2')'*inv(s2)*(x(i,:)'-m2')) + log(pc2);
        end
        if g1(i)>g2(i)
            cpred(i) = 1;
        else cpred(i) = 2;
        end
        if cpred(i) ~= c(i)
            vsum = vsum + 1;
        end
    end
    err = vsum/n;
    fprintf("error on test set =%f\n", err);
end