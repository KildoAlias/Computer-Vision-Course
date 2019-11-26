function m=masks(input)

dxmask=[0 0 0 0 0;0 0 0 0 0; 0 -1/2 0 1/2 0;0 0 0 0 0; 0 0 0 0 0];
dymask=[0 0 0 0 0; 0 0 -1/2 0 0; 0 0 0 0 0 ;0 0 1/2 0 0; 0 0 0 0 0];

dxxmask=[ 0 0 0 0 0;0 0 0 0 0;0 1 -2 1 0;0 0 0 0 0; 0 0 0 0 0];
dyymask=[ 0 0 0 0 0;0 0 1 0 0; 0 0 -2 0 0; 0 0 1 0 0; 0 0 0 0 0];

if (input=="x")
   m=dxmask;
elseif (input=="y")
    m=dymask;
    
elseif (input=="xy")
    dxymask=conv2(dxmask,dymask,"same");
    m=dxymask;
    
    
elseif (input=="yx")
    dyxmask=conv2(dymask,dxmask,'same');
    m=dyxmask;    
    
elseif (input=="xx")
    m=dxxmask;
    
elseif (input=="yy")
    m=dyymask;
    
elseif (input=="xxx")
    
    dxxxmask=conv2(dxxmask,dxmask,'same');
    m=dxxxmask;
    
elseif (input=="yyy")
    dyyymask=conv2(dyymask,dymask,'same');
    m=dyyymask;
    
elseif (input=="xxy")
    dxxymask=conv2(dxxmask,dymask,'same');
    m=dxxymask;
    
elseif (input=="xyy")
    dxyymask=conv2(dxmask,dyymask,'same');
    m=dxyymask; 
    
end

end