function edge_img = text_edge_detector(image, threshold)
    % Create a filter bank
    filter_bank = create_filter_bank();
    
    % Convert the input image from color to grayscale=
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    [rows,cols]=size(image);
    edge_img=zeros(size(image));
    % Rescale the image data to the range [0, 1]
    image = im2double(image);
    
    % Initialize edge and orientation maps
    edge_map = zeros(size(image));
    orient_map = zeros(size(image));
    
    % Apply filters and histogram-based edge detector
    for f = 1:numel(filter_bank)
        % Apply the filter to the image
        filtered_image = imfilter(image, filter_bank{f}, 'conv');
        
        % Use histogram-based edge detector on the filtered image
        [edge_map(:,:,f), orient_map(:,:,f)] = hist_edge_detector(filtered_image, 5,8,16);
    end
    
    % Combine the filter responses to obtain the maximum strength map
    [max_strength_map, angle_map] = max(edge_map, [], 48);
    
    % Perform non-maximal suppression

    for i=5:rows-5
        for j=5:cols -5
            angle1=angle_map(i,j);
            if(angle1>360)
                angle1=angle1-360;
            end
            if(angle1>=340 || angle1<=22.5) || (angle1>=157.5 && angle1<=202.5)  % horizontal
                if (image(i,j+1)>image(i,j)) || (image(i,j-1)>image(i,j))
                    max_strength_map(i,j)=0;
                end         
            elseif (angle1>22.5 && angle1<=67.5) || (angle1>202.5 && angle1<=247.5) % 45 degree
                if (image(i+1,j+1)>image(i,j)) || (image(i-1,j-1)>image(i,j))
                    max_strength_map(i,j)=0;
                end
            elseif (angle1>67.5 && angle1<=112.5) || (angle1>247.5 && angle1<=292.5) %vertical
                if (image(i-1,j)>image(i,j)) ||(image(i+1,j)>image(i,j))
                    max_strength_map(i,j)=0;
                end
            else %135
                if (image(i-1,j+1)>image(i,j)) || (image(i+1,j-1)>image(i,j))
                    max_strength_map(i,j)=0;
                end
            end
        end
    end

    
    % Threshold to obtain the binary edge map
    for i=1:rows
        for j=1:cols
            if max_strength_map(i,j)>=threshold
                edge_img(i,j) = 1;
            else
                edge_img(i,j) = 0;
            end
        end
    end
end

