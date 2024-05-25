i = 0:18;
yi = [502.8, 525.0, 514.3, 451.0, 326.5, 188.6, 92.2, 59.6, 62.2, 102.7, ...
    147.1, 191.6, 236.0, 280.5, 324.9, 369.4, 413.8, 458.3, 502.8];

theta = linspace(0, 2*pi, 19);
R = 300; % 底圆半径
theta_interp = linspace(0, 2*pi, 100);
yi_interp = interp1(theta, yi, theta_interp, 'spline');

x_interp = R * cos(theta_interp);
y_interp = R * sin(theta_interp);

% 绘制圆周上的柱高曲线
figure;
plot(theta_interp, yi_interp, 'r', 'LineWidth', 2);
xlabel('角度');
ylabel('柱高（mm）');
title('\bf圆周上的柱高曲线（三次样条插值）');

% 绘制圆周和对应柱高点
figure;
plot(x_interp, y_interp, 'b', 'LineWidth', 1.5);
hold on;
scatter(x_interp, y_interp, 'r', 'filled');
xlabel('x（mm）');
ylabel('y（mm）');
title('\bf圆周及对应柱高点');
axis equal;

% 补充绘制圆周上的三维曲线
figure;
plot3(x_interp, y_interp, yi_interp, 'r', 'LineWidth', 1.5);
xlabel('x（mm）');
ylabel('y（mm）');
zlabel('柱高（mm）');
title('\bf圆周上的三维曲线（三次样条插值）');
grid on;