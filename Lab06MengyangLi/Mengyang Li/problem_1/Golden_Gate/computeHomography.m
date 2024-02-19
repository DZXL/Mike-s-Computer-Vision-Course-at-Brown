
function H = computeHomography(p1, p2)
    A = [];
    for i = 1:4
        x = p1(i,1);
        y = p1(i,2);
        x_p = p2(i,1);
        y_p = p2(i,2);
        A = [A; 
            -[x, y, 1] zeros(1,3) x_p*[x, y, 1];
             zeros(1,3) -[x, y, 1] y_p*[x, y, 1]];
    end
    [~,~,V] = svd(A);
    H = reshape(V(:,9), 3, 3)';
end
