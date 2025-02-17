%%
close all
clear all
K=10;     % number of clusters used
L = 20 ;            % number of iterations
seed = 0;            % seed used for random initialization
scale_factor = 1;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

figure()
I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imshow(Inew)

% imwrite(Inew,'result/kmeans1.png')
% imwrite(I,'result/kmeans2.png')


%% Change L
close all
clear all
K = 10;               % number of clusters used
Lv = [20,30,40,50,100];              % number of iterations
seed = 0;            % seed used for random initialization
scale_factor = 1;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

figure()
for i=1:length(Lv)
L=Lv(i);
I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc

if i==1
    centers_conv=sum(centers,2);
else 
    centers_err(i,:)=abs(centers_conv-sum(centers,2));
end


Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
subplot(1,length(Lv),i)
imshow(I)
end
error=nansum(centers_err,2);
figure()
plot(Lv,error)
xlabel('L')
ylabel('error')
title('Error in centers compared to L=500')
% imwrite(Inew,'result/kmeans1.png')
% imwrite(I,'result/kmeans2.png')



%% change K
close all
clear all
Kv = [7,10];               % number of clusters used
L = 20 ;            % number of iterations
seed = 0;            % seed used for random initialization
scale_factor = 1;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

figure()
for i=1:length(Kv)
K=Kv(i);
I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
subplot(1,length(Kv),i)
imshow(I)
title(['K=',num2str(Kv(i))])
end

% imwrite(Inew,'result/kmeans1.png')
% imwrite(I,'result/kmeans2.png')