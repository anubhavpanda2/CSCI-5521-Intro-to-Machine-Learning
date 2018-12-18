[img,cmap]= imread('goldy.bmp');
img_rgb =ind2rgb(img,cmap);
img_double=im2double(img_rgb);
finalmatrix=reshape(img_double, [],3);
[idx, M]=kmeans(finalmatrix,7);
N=size(finalmatrix,1);
Compress=zeros(N,3);
for j=1:N
    Compress(j,:)=M(idx(j),:);
end
Compress=reshape(Compress, size(img_rgb,1),size(img_rgb,2),3);        
figure
imagesc(Compress);
[ h,M,Q] = EMG('goldy.bmp',7,1);
%[ h,M,Q] = EMG('goldy.bmp',7,0);
%all(eig(S(:,:,4)) > eps)