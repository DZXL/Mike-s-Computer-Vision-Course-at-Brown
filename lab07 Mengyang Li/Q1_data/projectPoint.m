function projected_point = projectPoint(K, R, T, point3D)
    P = K * [R, T];
    point3D_homogeneous = [point3D, 1]';
    point2D_homogeneous = P * point3D_homogeneous;
    point2D = point2D_homogeneous(1:2) / point2D_homogeneous(3);
    projected_point = point2D';
end
