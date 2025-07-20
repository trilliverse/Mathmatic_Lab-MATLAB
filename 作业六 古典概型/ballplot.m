%% ballplot.m 可视化胜率随n增大的变化规律
function ballplot(maxn)
    pA_values = zeros(1, maxn);
    pB_values = zeros(1, maxn);
    pC_values = zeros(1, maxn);

    parfor n = 1:maxn
        [~, ~, ~, pA, pB, pC] = Ball(4, 8, n);
        pA_values(n) = pA;
        pB_values(n) = pB;
        pC_values(n) = pC;
    end

    % 绘制图表
    figure;
    plot(1:maxn, pA_values, 'r', 'LineWidth', 1);
    hold on;
    plot(1:maxn, pB_values, 'b', 'LineWidth', 1);
    plot(1:maxn, pC_values, 'k', 'LineWidth', 1);
    legend({'$pA$', '$pB$', '$pC$'}, 'Interpreter', 'latex');
    xlabel('$n$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$p$', 'Interpreter', 'latex');
    title('\bfA,B,C获胜概率随 n 的变化', 'FontSize', 12);
    grid on;
    hold off;
end
