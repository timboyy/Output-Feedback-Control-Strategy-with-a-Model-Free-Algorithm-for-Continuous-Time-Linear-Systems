function matrix = restore(vec)
    L = size(vec, 1);
    n = sqrt(2*L+1/4)-1/2;
    m = n;
    matrix = zeros(m, n);
    index = 1;
    for i = 1:m
        for j = i:n
            matrix(i, j) = vec(index);
            matrix(j, i) = vec(index);
            index = index + 1;
        end
    end
end