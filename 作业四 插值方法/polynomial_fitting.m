x = [0 3 5 7 9 11 12 13 14 15];
y = [0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];


p4 = polyfit(x, y, 4);
p5 = polyfit(x, y, 5);
p6 = polyfit(x, y, 6);
p7 = polyfit(x, y, 7);
p8 = polyfit(x, y, 8);
p9 = polyfit(x, y, 9);

xi = 0:0.1:15;

y_fit4 = polyval(p4, xi);
y_fit5 = polyval(p5, xi);
y_fit6 = polyval(p6, xi);
y_fit7 = polyval(p7, xi);
y_fit8 = polyval(p8, xi);
y_fit9 = polyval(p9, xi);

% plot(x, y, 'b-', 'LineWidth', 2);
% hold on
% plot(xi, y_fit, 'r--', 'LineWidth', 2);
% plot(x, y, 'k*', 'MarkerSize', 10, 'LineWidth', 1);
% legend('原始数据', '多项式拟合');
% xlabel('$x$', 'Interpreter','latex');
% ylabel('$y$', 'Interpreter','latex');
% title('\bf多项式拟合曲线');
% hold off

plot(x, y, 'k*', xi, y_fit4, xi, y_fit5, xi, y_fit6, xi, y_fit7, xi, y_fit8, xi, y_fit9);
legend('原始数据', '4阶拟合', '5阶拟合', '6阶拟合', '7阶拟合', '8阶拟合', '9阶拟合');
xlabel('$x$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
title('\bf多项式拟合曲线');
%% 
x = [0 3 5 7 9 11 12 13 14 15];
y = [0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];

p = polyfit(x, y, 7);
xi = 0:0.1:15;
y_fit = polyval(p, xi);

plot(x, y, 'b-', 'LineWidth', 2);
hold on
plot(xi, y_fit, 'r--', 'LineWidth', 2);
plot(x, y, 'k*', 'MarkerSize', 10, 'LineWidth', 1);
legend('原始数据', '多项式拟合');
xlabel('$x$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
title('\bf7阶多项式拟合');
hold off