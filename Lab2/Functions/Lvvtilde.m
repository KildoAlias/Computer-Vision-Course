function Lvv= Lvvtilde(inpic,t,shape)
if (nargin < 3)
shape = "same";
end

inpic=gaussfft(inpic,t);

mask=masks('x');
Lx=conv2(inpic,mask,shape);
mask=masks('y');
Ly=conv2(inpic,mask,shape);
mask=masks('xy');
Lxy=conv2(inpic,mask,shape);
mask=masks('yy');
Lyy=conv2(inpic,mask,shape);
mask=masks('xx');
Lxx=conv2(inpic,mask,shape);

Lvv=(Lx.^2.*Lxx)+(2.*Lx.*Ly.*Lxy)+(Ly.^2.*Lyy);

end