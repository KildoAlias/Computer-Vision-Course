function pixels = Lv(inpic,t,shape)
if (nargin < 3)
shape = "same";
end

inpic=discgaussfft(inpic,t);

dxmask=[-1 0 1; -2 0 2; -1 0 1];
dymask=[-1 -2 -1; 0 0 0 ; 1 2 1];
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
pixels = Lx.^2 + Ly.^2;
end