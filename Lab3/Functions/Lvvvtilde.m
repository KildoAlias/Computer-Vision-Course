function Lvvv = Lvvvtilde(inpic,t,shape)
if (nargin < 3)
shape = "same";
end

inpic=gaussfft(inpic,t);

mask=masks("xxx");
Lxxx = conv2(inpic,mask, shape);
mask=masks("yyy");
Lyyy= conv2(inpic,mask,shape);
mask=masks('x');
Lx=conv2(inpic,mask,shape);
mask=masks('y');
Ly=conv2(inpic,mask,shape);
mask=masks('xxy');
Lxxy=conv2(inpic,mask,shape);
mask=masks('xyy');
Lxyy=conv2(inpic,mask,shape);


Lvvv= ((Lx.^3).*Lxxx)+(3.*Lx.^2.*Ly.*Lxxy)+(3.*Lx.*Ly.^2.*Lxyy)+(Ly.^3.*Lyyy);
end