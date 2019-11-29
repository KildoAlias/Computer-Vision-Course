function K_centers=init_K_clusters(image,K,seed)
if nargin<3
    seed='shuffle';
    disp('Seed set to shuffle')
end
rng(seed);
K_p=floor(K/4);
K=K-(K_p*4);

[H,W,~]=size(image);
K_ulx=randi([1,floor(W/2)-1],1,K_p);
K_uly=randi([1,floor(H/2)-1],1,K_p);

K_urx=randi([floor(W/2),W],1,K_p);
K_ury=randi([1,floor(H/2)-1],1,K_p);

K_llx=randi([1,floor(W/2)-1],1,K_p);
K_lly=randi([floor(H/2),H],1,K_p);

K_lrx=randi([floor(W/2),W],1,K_p);
K_lry=randi([floor(H/2),H],1,K_p);

if K>0
    K_restx=randi([1,W],1,K);
    K_resty=randi([1,H],1,K);
    K_c=[K_ulx,K_urx,K_llx,K_lrx,K_restx;K_uly,K_ury,K_lly,K_lry,K_resty];
    
else
    K_c=[K_ulx,K_urx,K_llx,K_lrx;K_uly,K_ury,K_lly,K_lry];

end

K_centers(1,:)=diag(image(K_c(2,:),K_c(1,:),1));
K_centers(2,:)=diag(image(K_c(2,:),K_c(1,:),2));
K_centers(3,:)=diag(image(K_c(2,:),K_c(1,:),3));


end