function[p,M,q]=EMG(imgFile,k,flag)
lambda=0.00001;
 if ~exist('flag','var')
      flag = 0;
 end
[img,cmap] = imread(imgFile);
img_rgb = ind2rgb(img,cmap);
img_double = im2double(img_rgb);
finalmatrix=reshape(img_double,[],3);
N=size(finalmatrix,1);
  [idx, M]=kmeans(finalmatrix,k,'MaxIter',2,'EmptyAction','singleton');
  p=zeros(N,k);
 for i=1:k
     if flag~=1
    S(:,:,i)=cov(finalmatrix(idx(:)==i,:));
     else
        S(:,:,i)=cov(finalmatrix(idx(:)==i,:))+lambda*eye(3,3); 
     end
    pi(i)= sum(idx(:)==i)/N;
 end
 q=zeros(150,2);
for iter=1:150
   s1=zeros(N,1);
    for i= 1:k
       oldp(:,i)=mvnpdf(finalmatrix,M(i,:),S(:,:,i));
        p(:,i)=pi(i)*oldp(:,i);
        s1(:)=s1(:)+p(:,i);
    end
    %oldp=p;
%p=bsxfun(@rdivide, p, sum(p,2));
p=p./s1;
Ni=sum(p);
updatedM=p'*finalmatrix;
updatedM=updatedM./Ni';
updatedpi=Ni/N;
updatedsigma=zeros(3,3,k);
 for i=1:k
        for j=1:N
            
     if flag~=1
        updatedsigma(:,:,i)=updatedsigma(:,:,i)+ p(j,i).*(finalmatrix(j,:)-M(i,:))'*(finalmatrix(j,:)-M(i,:));
     else
            updatedsigma(:,:,i)=updatedsigma(:,:,i)+ p(j,i).*(finalmatrix(j,:)-M(i,:))'*(finalmatrix(j,:)-M(i,:))+lambda*eye(3,3);
     end
        
        end
        updatedsigma(:,:,i)=updatedsigma(:,:,i)./Ni(i);
 end
%   for j=1:N
%      for i=1:k
%          temp=mvnpdf(finalmatrix(j,:),M(i,:),S(:,:,i));
%          if temp<=0
%              temp=0.0000001;
%          end
%          q(iter,1)=q(iter,1)+p(j,i)*(log(pi(:,i))+log(temp));
%      end
%   end
 %p(p==0)=0.0000001;
 oldp(oldp==0)=0.00000001;
    pi(pi==0)=0.00000001; 
    q(iter,1)=sum(p)*transpose(log(pi))+sum(sum(p.*log(oldp))); 

%  oldp(oldp==0)=0.0000001;
%     pi(pi==0)=0.0000001;
%     q(iter)=sum(p)*transpose(log(pi))+sum(sum(p.*log(oldp)));

  S=updatedsigma;
  M=updatedM;
  pi=updatedpi;
%   
%    for j=1:N
%      for i=1:k
%          temp=mvnpdf(finalmatrix(j,:),M(i,:),S(:,:,i));
%          if temp<=0
%              temp=0.0000001;
%          end
%          q(iter,2)=q(iter,2)+p(j,i)*(log(pi(:,i))+log(temp));
%      end
%   end
 for i=1:k
        oldp(:,i)=mvnpdf(finalmatrix,M(i,:),S(:,:,i));
    end
oldp(oldp==0)=0.00000001;
    pi(pi==0)=0.00000001; 
    q(iter,2)=sum(p)*transpose(log(pi))+sum(sum(p.*log(oldp))); 

end
%apanda
%        q(1:149,2)=q(2:150,1);
%           for j=1:N
%      for i=1:k
%          temp=mvnpdf(finalmatrix(j,:),M(i,:),S(:,:,i));
%          if temp<=0
%              temp=0.0000001;
%          end
%          q(150,2)=q(iter,2)+p(j,i)*(log(pi(:,i))+log(temp));
%      end
%   end

[ ~, row_def ] = max(p, [], 2 );

Compressedimage=zeros(N,3);
for j=1:N
    Compressedimage(j,:)=M(row_def(j),:);
end
Compressedimage=reshape(Compressedimage, size(img_rgb,1),size(img_rgb,2),3);        
figure;
imagesc(Compressedimage);
figure;
% x=1:150;
% plot(x,q(2,x));

x=0.5:0.5:150;
x1=0.5:1:149.5;
x2=1:1:150;
Q=transpose(q);
plot(x,Q(:));
hold all;
scatter(x1,q(:,1),'.','r');
scatter(x2,q(:,2),'.','G');
hold off;

%apanda
end