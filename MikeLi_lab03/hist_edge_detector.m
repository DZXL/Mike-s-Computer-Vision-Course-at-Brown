function [edge_map, ori_map] = hist_edge_detector(img,rad, num_orient,numbins)
    %Load the image and convert to grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = im2double(img);

    % get size of the image
    [rows,cols]=size(img);
    ori_map=zeros(rows,cols);
    edge_map=img;

    % set 8 orientations
    orientation=linspace(0,pi,8);
    m=1;
    n=1;
    for i=1+rad:rows-rad
        for j=1+rad:cols-rad
            chi_s=zeros(1,num_orient);
            for o=1:num_orient
            % define a circle
            [X,Y]=meshgrid(-rad:rad,-rad:rad);
            for p=1:2*rad+1 
                for q=1:2*rad+1
                    xyvalue=X(p,q)^2+Y(p,q)^2;
                    % decide if the pixel is in the circle
                    if(xyvalue<=rad^2)% inside the circle
                        % get the angle of pixel
                        if(Y(p,q)>=0 && X(p,q)>=0)
                            angle=atan(Y(p,q)/X(p,q));
                        elseif(Y(p,q)>=0 && X(p,q)<=0)
                            angle=pi+atan(Y(p,q)/X(p,q));
                        elseif(Y(p,q)<=0 && X(p,q)>=0)
                            angle=2*pi+atan(Y(p,q)/X(p,q));
                        else
                            angle=pi+atan(Y(p,q)/X(p,q));
                        end
                        % decide left or right
                        if(angle>orientation(o)+pi)% left half
                            left(m)=img(i+(p-rad-1),j+(p-rad-1));
                            m=m+1;
                        else% right half
                            right(n)=img(i+(p-rad-1),j+(p-rad-1));
                            n=n+1;
                        end
                    else
                        % out of the cirle, ignore
                    end
                end
            end
            % compare
            g1=histcounts(left,numbins);
            h1=histcounts(right,numbins);
            % normalization
            g=g1./sum(g1);
            h=h1./sum(h1);
            for n=1:numbins
                 chi_s(o)=chi_s(o)+0.5*(g(n)-h(n))^2/(g(n)+h(n)+eps);                
            end
            m=1;
            n=1;
            end
            [value,index]=max(chi_s);
            ori_map(i,j)=orientation(index);
        end
    end
    % non-max supression
    for i=rad:rows-rad 
        for j=rad:cols-rad 
            angle1=ori_map(i,j)/pi*180+90;
            if(angle1>360)
                angle1=angle1-360;
            end
            if(angle1>=340 || angle1<=22.5) || (angle1>=157.5 && angle1<=202.5)  % horizontal
                if (img(i,j+1)>img(i,j)) || (img(i,j-1)>img(i,j))
                    edge_map(i,j)=0;
                end         
            elseif (angle1>22.5 && angle1<=67.5) || (angle1>202.5 && angle1<=247.5) % 45 degree
                if (img(i+1,j+1)>img(i,j)) || (img(i-1,j-1)>img(i,j))
                    edge_map(i,j)=0;
                end
            elseif (angle1>67.5 && angle1<=112.5) || (angle1>247.5 && angle1<=292.5) %vertical
                if (img(i-1,j)>img(i,j)) ||(img(i+1,j)>img(i,j))
                    edge_map(i,j)=0;
                end
            else 
                if (img(i-1,j+1)>img(i,j)) || (img(i+1,j-1)>img(i,j))
                    edge_map(i,j)=0;
                end
            end
        end
    end
end