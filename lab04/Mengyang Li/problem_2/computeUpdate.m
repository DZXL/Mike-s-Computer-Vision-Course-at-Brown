function eta = computeUpdate(W0, Wk, Ix, Iy)
    % 计算光流方程的参数

    % 差异图像
    dI = W0 - Wk;

    % 窗口内的梯度平方和
    Ix2 = sum(Ix(:) .* Ix(:));
    Iy2 = sum(Iy(:) .* Iy(:));
    Ixy = sum(Ix(:) .* Iy(:));

    % 梯度与差异图像的乘积
    IxdI = sum(Ix(:) .* dI(:));
    IydI = sum(Iy(:) .* dI(:));

    % 计算更新矩阵 M^-1 * b
    M = [Ix2, Ixy; Ixy, Iy2];
    b = [IxdI; IydI];

    % 检查M是否可逆
    if det(M) == 0
        eta = [0; 0];
        return;
    end

    % 计算更新
    eta = M \ b;
end
