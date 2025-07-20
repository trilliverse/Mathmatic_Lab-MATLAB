function dispModel(b, bint, stats)
    for i = 1:length(b)
        fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, b(i), bint(i,1), bint(i,2));
    end
    fprintf('R^2 = %.4f\n', stats(1));
    fprintf('F = %.4f\n', stats(2));
    fprintf('p = %.4e\n', stats(3));
    fprintf('S_e^2 = %.4f\n\n', stats(4));
end