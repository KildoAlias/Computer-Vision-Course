function [linepar, acc] =houghcircle(curves,magnitude,nrho, ntheta, threshold, nlines, verbose)
% OUTPUT
% • linepar is a list of (ρ, θ) parameters for each line segment,
% • acc is the accumulator matrix of the Hough transform,
% INPUT
% • curves are the polygons from which the transform is to be computed,
% • magnitude is an image with one intensity value per pixel
% • nrho is the number of accumulators in the ρ direction,
% • ntheta is the number of accumulators in the θ direction,
% • threshold is the lowest value allowed for the given magnitude,
% • nlines is the number of lines to be extracted,
% • verbose denotes the degree of extra information and figures that will
% be shown. (0: silent, 1:accumulator plot, 2:Houghlines and original, 3:only Houghlines)

% Allocate accumulator space
acc=zeros(nrho,ntheta);

% Define a coordinate system in the accumulator space
delta_theta=180/ntheta; 
delta_r=1;  % 1 pixel accuracy
coordinate_theta=[-90:delta_theta:90];
coordinate_r=[-nrho/2:delta_r:nrho/2];

% Loop over all the input curves (cf. pixelplotcurves)
for i=1:size(curves,2)
    x=curves(2,i);
    y=curves(1,i);

    

    %valid=1;
    theta=coordinate_theta(1);
    for j=1:ntheta
    % Compute rho for each theta value
    
        if x>0 && y>0 
            valid=(magnitude(ceil(x),ceil(y))>threshold);
            r=x*cosd(theta)+ y*sind(theta);
            % Compute index values in the accumulator space
            r=ceil(r+(nrho/2));
            if r<nrho+1 && r>0 && valid==1
                if verbose==3 
                    acc(r,j)=acc(r,j)+magnitude(round(x),round(y));
                else
                    acc(r,j)=acc(r,j)+1;
                end
            end
            theta=theta+delta_theta;
        end
    end
    
end
[ pos, value] = locmax8(acc);
[~,index] = sort(value);
nmaxima = size(value, 1);


linepar=zeros(2,nlines);
for idx = 1:nlines
    rhoidxacc = pos(index(nmaxima - idx + 1), 1);
    thetaidxacc = pos(index(nmaxima - idx + 1), 2);
    linepar(1,idx)=coordinate_r(rhoidxacc);
    linepar(2,idx)=coordinate_theta(thetaidxacc); 
end

end