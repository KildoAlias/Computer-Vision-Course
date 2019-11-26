function pixels = Lv(inpic, shape)
if (nargin < 2)
shape = "same";
end
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
pixels = Lx.^2 + Ly.^2;
end