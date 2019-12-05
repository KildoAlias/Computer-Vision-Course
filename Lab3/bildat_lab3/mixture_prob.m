function prob = mixture_prob(image, K, L, mask)
seed=1;
rng(seed)
image=single(image);
mask=single(mask);
[W,H,D]=size(image);
im_re=reshape(image,W*H,D);
mask_re=reshape(mask,W*H,1);
image_masked=im_re(mask_re==1,:);
[segm,centers] = kmeans_segm(image_masked, K, L,seed);
K=size(centers,1);
[W2,H2]=size(segm);
w_norm=W2*H2;

for k=1:K
    Qv(:,:,k)=eye(3,3)*(rand()*256);
    w(k)=length(find(segm==k));
    w(k)=w(k)/w_norm;
end
mean=centers;

for l=1:L

    for k=1:K
        
        if isnan(mean(k,:))
            mean(k,:)=0;
        end
        Q=Qv(:,:,k);
        diff = bsxfun(@minus, image_masked, mean(k,:));
        di=sum(diff*inv(Q).*diff,2);
        g=(1/(sqrt((2*pi)^3*det(Q))))*exp((-1/2)*di);
        p(k,:)=w(k).*g;
    end
    % Expectation #####
    p_norm=sum(p,1);
    P=p./p_norm;
    
    % Maximazation #####
    
    %update weight
    w=sum(P,2)';
    w=w/w_norm;
    
    for k=1:K
    %update mean
    mean(k,:)=(sum(P(k,:).*image_masked',2))./(sum(P(k,:),2))';
    
    %update cov (Q)
    diff = bsxfun(@minus, image_masked, mean(k,:));
    Qv(:,:,k)=(((P(k,:).*diff')*diff))./(sum(P(k,:),2));
    
    end
end


for k=1:K
  
    Q=Qv(:,:,k);
    diff = bsxfun(@minus, im_re, mean(k,:));
    di=sum(diff*inv(Q).*diff,2);
    g=(1/(sqrt((2*pi)^3*det(Q))))*exp((-1/2)*di);
    p2(k,:)=w(k).*g;
end
prob=sum(p2,1);



end


