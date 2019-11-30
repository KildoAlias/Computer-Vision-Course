K = 3;               % number of clusters used
L = 10;              % number of iterations
seed = 1;            % seed used for random initialization
scale_factor = 0.5;  % image downscale factor
image_sigma = 4.0;   % image preblurring scale

I = imread('IMG_0292.JPG');
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
imwrite(Inew,'result/kmeans1.png')
imwrite(I,'result/kmeans2.png')

