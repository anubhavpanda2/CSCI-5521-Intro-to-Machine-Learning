 S = load('data2.mat');
 red=(S.y==1);
 green=(S.y==-1);
 blue=(S.y==0);
 color=[red,green,blue];
W=rand(2,1);
%W(3,1)=0
W(2,1)=-1;
W(1,1)=1;
X1=rand(1,40);
size(X1,2);
X1(1,:)=S.X(1:40,1);
X2=rand(1,40);
X2(1,:)=S.X(1:40,2);
 scatter(X1(1:40),X2(1:40),5,color)
 [m,n]=size(S.X);
 f=[zeros(n,1);ones(m,1)]; 
 A1=[S.X.*repmat(S.y,1,n),eye(m,m)]; 
 A2=[zeros(m,n),eye(m,m)]; 
 A=-[A1;A2]; 
 b=[-ones(m,1);zeros(m,1)]; 
 x = linprog(f,A,b);% solve LP w=x(1:n);
 w=x(1:n)
 X=S.X';
 mxx = max(X1);
mnx=min(X1);
 x3=mnx:0.01:mxx;
x4=-(w(1)*x3)/w(2);
hold on
plot(x3,x4)
axis([min(X(1,:)) max(X(1,:)) min(X(2,:)) max(X(2,:))])