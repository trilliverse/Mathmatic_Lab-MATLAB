x = [0 3 5 7 9 11 12 13 14 15];
y = [0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];

xi = 0:0.1:15;
yi_linear = interp1(x, y, xi, 'linear'); % 分段线性插值

plot(x, y, 'b-', 'LineWidth', 2);
hold on
plot(xi, yi_linear, 'r--', 'LineWidth', 2);
plot(x, y, 'k*', 'MarkerSize', 10, 'LineWidth', 1);
hold off
legend('原始数据', '分段线性插值');
xlabel('$x$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
title('\bf分段线性插值曲线');
