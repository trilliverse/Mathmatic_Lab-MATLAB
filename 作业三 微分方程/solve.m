t = [0 30];
x0 = [0.12; 0.003; 0.01];
[t1, x1] = ode45(@myODEs, t, x0);

t = [0 133];
x0 = [0.01; 0.00001; 0.001];
[t2, x2] = ode45(@myODEs, t, x0);

% 绘制第一组初始条件的解
figure;
plot(t1, x1(:,1), 'r', 'LineWidth', 2);
hold on;
plot(t1, x1(:,2), 'g', 'LineWidth', 2);
plot(t1, x1(:,3), 'b', 'LineWidth', 2);
hold off;
title('\bf第一组初始条件的解');
legend({'$x(t)$', '$y(t)$', '$z(t)$'}, 'Interpreter', 'latex');
xlabel('$t$', 'Interpreter', 'latex')
ylabel('$x, y, z$', 'Interpreter', 'latex');
grid on; grid minor;

% 绘制第二组初始条件的解
figure;
plot(t2, x2(:,1), 'r', 'LineWidth', 2);
hold on;
plot(t2, x2(:,2), 'g', 'LineWidth', 2);
plot(t2, x2(:,3), 'b', 'LineWidth', 2);
hold off;
title('\bf第二组初始条件的解');
legend({'$x(t)$', '$y(t)$', '$z(t)$'}, 'Interpreter', 'latex');
xlabel('$t$', 'Interpreter', 'latex')
ylabel('$x, y, z$', 'Interpreter', 'latex');
grid on; grid minor;
