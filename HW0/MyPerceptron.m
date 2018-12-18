function [W,round] = MyPerceptron(Xinit,Y,W,rate)
%S = load('data1.mat');
 red=(Y==1);
 green=(Y==-1);
 blue=(Y==0);
 color=[red,green,blue];
%W=rand(2,1);
%W(3,1)=0
%W(2,1)=-1;
%W(1,1)=1;
X1=rand(1,40);
size(X1,2);
X1(1,:)=Xinit(1:40,1);
X2=rand(1,40);
X2(1,:)=Xinit(1:40,2);
scatter(X1(1:40),X2(1:40),5,color)%S.y);
mxx = max(X1);
mnx=min(X1);
x1=mnx:0.01:mxx;
x2=-(W(1)*x1)/W(2);
%X=rand(2,40);
%x1(1:40,1)

X=Xinit';
 hold on
 plot(x1,x2)
 hold off
 err = 1;
%rate=10;
%W
round=0;
Y1=Y';
while err >0
    for i=1:40
        if sign(W'*X(:,i))~=Y1(i)
            W=W+rate * (X(:,i)*Y1(i)');
        end
    end
   % sm1=W'*X;
   %sm=sum(sign(W'*X)~=Y)
    err = sum(sign(W'*X)~=Y1)/40;
    round=round+1;
%round;
end
%round;
grid on
x3=mnx:0.01:mxx;
x4=-(W(1)*x1)/W(2);
hold on
plot(x3,x4)
axis([min(X(1,:)) max(X(1,:)) min(X(2,:)) max(X(2,:))])