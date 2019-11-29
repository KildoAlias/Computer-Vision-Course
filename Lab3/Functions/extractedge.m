function edgecurves = extractedge(inpic, scale,threshold,shape)
if (nargin < 4)
shape='same';
end

if (nargin < 3)
    shape='same';
    threshold=0;
end
lv=sqrt(Lv(inpic,scale, shape));
Lvv=Lvvtilde(inpic,scale,shape);
Lvvv=Lvvvtilde(inpic,scale,shape);

lv=(lv>threshold)-0.1;
lvvv=(Lvvv<0)-0.1;


curves = zerocrosscurves(Lvv, lvvv);
     
edgecurves = thresholdcurves(curves, lv);
     
 

end