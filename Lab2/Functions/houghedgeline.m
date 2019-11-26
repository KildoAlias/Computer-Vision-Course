function [linepar,acc] = houghedgeline(pic, scale, gradmag,threshold,nrho, ntheta, nlines, verbose)

curves=extractedge(pic,scale,threshold);


[linepar, acc] =houghline(curves,gradmag,nrho, ntheta,threshold, nlines, verbose);
if verbose==1 || verbose==3 
    
    x0=0;
    dx=10000000;

    for idx=1:nlines
        r=linepar(1,idx);
        theta=linepar(2,idx);
        if theta==0
            theta=10^-4;
        end

        y0=(r-(x0*cosd(theta)))/(sind(theta));
        dy=(r-(dx*cosd(theta)))/(sind(theta));

        outcurves(1,4*(idx-1)+1)=0;
        outcurves(2,4*(idx-1)+1)=3;
        outcurves(2,4*(idx-1)+2)=x0-dx;
        outcurves(1,4*(idx-1)+2)=y0-dy;
        outcurves(2,4*(idx-1)+3)=x0;
        outcurves(1,4*(idx-1)+3)=y0;
        outcurves(2,4*(idx-1)+4)=x0+dx;
        outcurves(1,4*(idx-1)+4)=y0+dy;
    end
    figure()
    subplot(1,2,1)
    showgrey(pic)
    title('Original image')
    
    subplot(1,2,2)
    overlaycurves(pic,outcurves)
    axis([1 size(pic, 2) 1 size(pic, 1)]);
    title('original image with lines')
    if verbose==1
        title('original image with lines, inc=1')
    else
        title('original image with lines, inc=mag')
    end
    
end 

    if verbose==2
        figure()
        imshow(imadjust(rescale(acc)))
        axis off
        axis normal
        colormap(gca, hot)
        xlabel('theta')
        ylabel('\rho')
    end
    

end