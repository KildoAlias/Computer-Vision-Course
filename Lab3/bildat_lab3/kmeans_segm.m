function [ segmentation, centers ] = kmeans_segm(image, K, L, seed)
[H,W,D]=size(image);

if D>1
    im_compare=reshape(image,(W*H),D);
    
    if nargin<4
        K_centers=init_K_clusters(image,K);
    else
        K_centers=init_K_clusters(image,K,seed);
    end

else
    K_centers=randi([1,256],3,K);
    im_compare=image;
end
im_compare=double(im_compare);
K_centers=double(K_centers');

dist=pdist2(im_compare,K_centers);
[~,mindist_idx]=min(dist,[],2);

mean_center=zeros(K,3);
for i=1:L
    for k=1:K
       mean_center(k,:)=mean(im_compare(mindist_idx==k,:));
       if i==L
            im_compare(mindist_idx==k,1)=mean_center(k,1);
            im_compare(mindist_idx==k,2)=mean_center(k,2);
            im_compare(mindist_idx==k,3)=mean_center(k,3);
       end
    end    
dist=pdist2(im_compare,mean_center);
nanvalues=isnan(dist);
nanvalues=nanvalues(1,:);
dist=dist(:,nanvalues==0);
mean_center=mean_center';
nancenters=isnan(mean_center);
nancenters=nancenters(1,:);
mean_center=mean_center(:,nancenters==0)';

[~,mindist_idx]=min(dist,[],2);
end
centers=mean_center;
% im_compare=round(single(im_compare));
% im_compare = prod(im_compare, 2);
segmentation=reshape(mindist_idx,H,1,1);
end