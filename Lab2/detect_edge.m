close all
inpic=imread('IMG_0292.JPG');
inpic=inpic(:,:,1);
inpic=single(inpic);
inpic=imresize(inpic,[256,256]);
t=4;
threshold=100;
curves=extractedge(inpic,t,threshold);

overlaycurves(inpic,curves)