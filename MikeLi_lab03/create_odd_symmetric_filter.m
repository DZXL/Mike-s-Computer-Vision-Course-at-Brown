function filter = create_odd_symmetric_filter(scale, orientation)
    % 滤波器尺度参数
    sigma1 = sqrt(2) ^ scale;
    sigma2 = 3 * sqrt(2) ^ scale;

    % 创建一个网格以生成滤波器
    filter_size = 2 * ceil(3 * max(sigma1, sigma2)) + 1;
    [X, Y] = meshgrid(-(filter_size-1)/2:(filter_size-1)/2, -(filter_size-1)/2:(filter_size-1)/2);

    % 旋转坐标以匹配指定的方向
    X_rot = X * cosd(orientation) - Y * sind(orientation);
    Y_rot = X * sind(orientation) + Y * cosd(orientation);

    % 计算奇对称滤波器的响应
    G_sigma2 = exp(-X_rot.^2 / (2 * sigma1^2)) / (sigma2 * sqrt(2 * pi));
    dG_sigma1 = (-X_rot / sigma1^3) .* exp(-X_rot.^2 / (2 * sigma1^2)) / sqrt(2 * pi);
    filter = G_sigma2 .* dG_sigma1;

    % 归一化滤波器
    filter = filter / max(abs(filter(:)));
end



