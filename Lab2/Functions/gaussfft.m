function pic_ut=gaussfft(pic, t)
sz=size(pic);

[X,Y]=meshgrid(-sz(1)/2:sz(1)/2-1,-sz(2)/2:sz(2)/2-1);
%X_C=fftshift(X);
%Y_C=fftshift(Y);

g=(1/(2*pi*t)).*exp(-((X.^2)+(Y.^2))/(2*t));

pic_fft=fft2(pic);
g_fft=fft2(g);

multi=pic_fft.*g_fft;
pic_ut=fftshift((ifft2(multi)));


end
