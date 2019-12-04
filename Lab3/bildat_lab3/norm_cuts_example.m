%close all
figure()
colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.6;      % cutting threshold
min_area = 30;          % minimum area of segment
max_depth = 6;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
% subplot(1,3,1)
% imshow(I)

Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imshow(I)

% subplot(1,3,2)
% imshow(I)
% subplot(1,3,3)
% imshow(Inew)
% imwrite(Inew,'result/normcuts1.png')
% imwrite(I,'result/normcuts2.png')

