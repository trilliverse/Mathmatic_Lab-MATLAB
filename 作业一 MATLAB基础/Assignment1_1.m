% 三次函数曲线
x1 = linspace(-5, 5, 1000);
y1 = x1.^3 + 2*x1.^2 - 3*x1 + 4;

% 四叶玫瑰线
theta = linspace(0, 2*pi, 1000);
r = cos(2*theta);

% 平面参数曲线
t = linspace(0, 2*pi, 1000);
x3 = (1 + sin(t) - 2*cos(4*t)) .* cos(t);
y3 = (1 + sin(t) - 2*cos(4*t)) .* sin(t);

% 周期函数
x4 = linspace(0, 4*pi, 1000);
y4 = sin(x4) + sin(2*x4);

% 绘制函数图像
subplot(2, 2, 1);
plot(x1, y1, 'b-', 'LineWidth', 2);
title('$y = x^3 + 2x^2 - 3x + 4$', 'Interpreter', 'latex');
grid on;
grid minor;

subplot(2, 2, 2);
polarplot(theta, r, 'r-', 'LineWidth', 2);
title('$r = \cos(2\theta)$', 'Interpreter', 'latex');
grid on;
grid minor;

subplot(2, 2, 3);
plot(x3, y3, 'k-', 'LineWidth', 2);
% title({'$x = (1 + \sin(t) - 2\cos(4t))\cos(t)$'; '$y = (1 + \sin(t) - 2\cos(4t))\sin(t)$'}, 'Interpreter', 'latex');
title({'$\left\{\begin{array}{l} x=(1 + \sin(t) - 2\cos(4t))\cos(t) \\ y=(1 + \sin(t) - 2\cos(4t))\sin(t) \end{array}\right.$'}, 'Interpreter', 'latex');
xlabel('X轴');  % 添加坐标轴标签
ylabel('Y轴');
grid on;
grid minor;

subplot(2, 2, 4);
plot(x4, y4, 'm-', 'LineWidth', 2);
title('$y = \sin(x) + \sin(2x)$', 'Interpreter', 'latex');
grid on;
grid minor;

% 添加整体标题
sgtitle('\bf\fontsize{13}不同类型曲线的绘制');

% 图形美化
axis equal;