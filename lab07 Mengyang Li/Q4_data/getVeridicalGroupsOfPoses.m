function [R_group, T_group] = getVeridicalGroupsOfPoses(Collect_R1s, Collect_R2s, Collect_T1s, Collect_T2s)


    N = size(Collect_R1s, 3);
    
    All_R1s = zeros(3,3,N);
    All_R2s = zeros(3,3,N);
    All_T1s = zeros(3,N);
    All_T2s = zeros(3,N);
    
    counter_R1_err = 0;
    counter_R2_err = 0;
    
    for i = 1:N
        if i == 1
            R_s1 = Collect_R1s(:,:,i);
            R_s2 = Collect_R2s(:,:,i);
            T_s1 = Collect_T1s(:,i);
            T_s2 = Collect_T2s(:,i);

            All_R1s(:,:,i) = R_s1;
            All_R2s(:,:,i) = R_s2;
            All_T1s(:,i) = T_s1;
            All_T2s(:,i) = T_s2;
        else
            R1 = Collect_R1s(:,:,i);
            R2 = Collect_R2s(:,:,i);
            T1 = Collect_T1s(:,i);
            T2 = Collect_T2s(:,i);
            
            %> Cluster R1 and R2
            R1s_to_R1_err = acos((trace(R_s1'*R1)-1)/2);
            R1s_to_R2_err = acos((trace(R_s1'*R2)-1)/2);
            if R1s_to_R1_err < R1s_to_R2_err
                All_R1s(:,:,i) = R1;
                All_R2s(:,:,i) = R2;
            else
                All_R1s(:,:,i) = R2;
                All_R2s(:,:,i) = R1;
            end
            
            if R1s_to_R1_err < 0.2 || R1s_to_R2_err < 0.2
                counter_R1_err = counter_R1_err + 1;
            else
                counter_R2_err = counter_R2_err + 1;
            end

            %> Cluster T1 and T2
            err1 = abs(dot(T_s1, T1)-1);
            err2 = abs(dot(T_s2, T1)-1);
            if err1 < err2
                All_T1s(:,i) = T1;
                All_T2s(:,i) = T2;
            else
                All_T1s(:,i) = T2;
                All_T2s(:,i) = T1;
            end
        end
    end
    
    %> Return the least variability of error in rotations
    if counter_R1_err > counter_R2_err
        R_group = All_R1s;
    else
        R_group = All_R2s;
    end

    %> For translation, either T1 or T2 is doable as the they only differ
    %  in the sign
    T_group = All_T1s;
end