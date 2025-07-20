%% myplot.m 可视化随n增大的数值变化规律
function myplot(maxn)
    pA_values = zeros(1, maxn);
    pB_values = zeros(1, maxn);
    p_values = zeros(1, maxn);

    parfor n = 1:maxn
        [~, ~, pA, pB, ~, p] = stake(n);
        pA_values(n) = pA;
        pB_values(n) = pB;
        p_values(n) = p;
    end
    % R2023a后 无需手动设置线程数量
    % parfor n = 1:maxn
    %     [~, ~, pA, pB, ~, p] = stake(n);
    %     pA_values(n) = pA;
    %     pB_values(n) = pB;
    %     p_values(n) = p;
    % end

    % 绘制图表
    figure;
    plot(1:maxn, pA_values, 'r', 'LineWidth', 1);
    hold on;
    plot(1:maxn, pB_values, 'b', 'LineWidth', 1);
    plot(1:maxn, p_values, 'k', 'LineWidth', 1);
    legend({'$pA$', '$pB$', '$p=pA/pB$'}, 'Interpreter', 'latex');
    xlabel('\bf$n$', 'Interpreter', 'latex', 'FontSize', 12);
    title('\bfpA、pB、p 随 n 的变化', 'FontSize', 12);
    legend('show', 'Interpreter', 'latex');
    grid on;
    hold off;
end