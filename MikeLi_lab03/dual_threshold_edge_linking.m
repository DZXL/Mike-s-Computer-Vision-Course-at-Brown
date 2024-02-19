function [Ih_ori,Ih,Il] = dual_threshold_edge_linking(image, Tl, Th)
    
    % Create two images by thresholding:
    Ih = intensity_edge_detector(image, Th);
    Ih_ori=Ih;
    
    
    Il = intensity_edge_detector(image, Tl);

    % Edge Linking: Follow edges in Ih
    [dy, dx] = gradient(double(Ih)); % Compute gradients
    [rows, cols] = size(Ih);
    
    for r = 1:rows
        for c = 1:cols
            if Ih(r, c) == 1 % Start with an edge point in Ih
                orientation = atan2(dy(r, c), dx(r, c)) * 180 / pi;
                % Round orientation to the closest of the 8 directions
                direction = round(orientation / 45) * 45; % 45 degrees interval
                
                while true
                    switch direction
                        case {0, 180} % Right or left
                            nextr = r;
                            nextc = c + 1;
                        case 45 % Bottom right
                            nextr = r + 1;
                            nextc = c + 1;
                        case 90 % Bottom
                            nextr = r + 1;
                            nextc = c;
                        case 135 % Bottom left
                            nextr = r + 1;
                            nextc = c - 1;
                        case -135 % Top left
                            nextr = r - 1;
                            nextc = c - 1;
                        case -90 % Top
                            nextr = r - 1;
                            nextc = c;
                        case -45 % Top right
                            nextr = r - 1;
                            nextc = c + 1;
                        otherwise
                            break; % Invalid direction
                    end
                    
                    if nextr > 0 && nextr <= rows && nextc > 0 && nextc <= cols
                        if Il(nextr, nextc) == 1 % Check if the pixel is in Il
                            Ih(nextr, nextc) = 1; % Add it to Ih
                            r = nextr;
                            c = nextc;
                        else
                            break; % Stop if it's not in Il
                        end
                    else
                        break; % Stop if out of bounds
                    end
                end
            end
        end
    end
end
