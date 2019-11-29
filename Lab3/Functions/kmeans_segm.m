function [ segmentation, centers ] = kmeans_segm(image, K, L, seed)
[H,W,D]=size(image);
K_centers=init_K_clusters(image,K,seed)';
im_compare=reshape(image,(W*H),D);
%image=double(image);
dist=pdist2(im_compare,K_centers);
[~,mindist_idx]=min(dist,[],2);
mean_center=K_centers;

for i=1:L

    for k=1:K
       mean_center(k,:)=mean(im_compare(mindist_idx==k));
    end

assign_values=mean_center(mindist_idx,:);
im_compare=assign_values;
end
centers=mean_center;
im_compare=round(single(im_compare));
im_compare = prod(im_compare, 2);
segmentation=reshape(im_compare,H,W,1);
end