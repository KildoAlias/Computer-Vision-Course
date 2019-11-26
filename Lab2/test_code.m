disp('Question 8')
close all
inpic =godthem256;
threshold=10 %10
scale=16; %32 
ntheta=180; %180
nlines=20; %20
verbose=1; %(0 for silent, 1 for plot of lines w. original, 2 for acc image, 3 to include magnitude in calculation) 



Diag=sqrt((size(inpic,2)-1)^2+(size(inpic,1)-1)^2);
nrho=(2*ceil((Diag/1)))+1;
outpic=Lv(inpic,1);
gradmagntools = sqrt(outpic);


[h,acc]=houghedgeline(inpic,scale,gradmagntools,threshold,nrho,ntheta,nlines,verbose);

% figure()
% imshow(imadjust(rescale(acc)))
% axis on
% axis normal
% colormap(gca, hot)

https://github.com/KildoAlias/Computer_Vision.git