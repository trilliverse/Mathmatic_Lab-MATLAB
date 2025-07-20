clc,clear
y1 = [22.1, 15.4, 11.7, 10.3, 11.4, 7.5, 13.0, 12.8, 14.6, 18.9, 19.3, 30.1, 28.2, 25.6, 37.5, 36.1, 39.8, 44.3]';
y2 = [7.2, 5.4, 7.6, 2.5, 2.4, 1.7, 4.3, 3.7, 3.9, 7.0, 6.8, 10.1, 9.4, 7.9, 14.1, 14.5, 14.9, 15.6]';
x1 = [1.89, 1.94, 1.95, 1.82, 1.85, 1.78, 1.76, 1.76, 1.75, 1.74, 1.70, 1.70, 1.68, 1.60, 1.61, 1.64, 1.67, 1.68]';
x2 = [6.1, 6.2, 6.3, 8.2, 9.8, 10.3, 10.5, 8.7, 7.4, 6.9, 5.2, 4.9, 4.3, 3.7, 3.6, 3.1, 1.8, 2.3]';

%% (1)分模型
% 普通型
X1 = [ones(size(y1)), x1, x2];
[b1, bint1, r1, rint1, stats1] = regress(y1, X1);
figure(1);
rcoplot(r1, rint1);
fprintf('普通型汽车销售量模型:\n');
dispModel(b1, bint1, stats1);

% 豪华型
[b2, bint2, r2, rint2, stats2] = regress(y2, X1);
figure(2);
rcoplot(r2, rint2);
fprintf('豪华型汽车销售量模型:\n');
dispModel(b2, bint2, stats2);

%% (2)统一模型
x3 = [zeros(length(y1), 1); ones(length(y2), 1)];
y = [y1; y2];
x1_all = [x1; x1];
x2_all = [x2; x2];
X = [ones(length(x1_all), 1), x1_all, x2_all, x3];

[b, bint, r, rint, stats] = regress(y, X);
figure(3);
rcoplot(r, rint);

fprintf('统一模型:\n');
dispModel(b, bint, stats);

%% (3)计算残差并绘制散点图
% 预测值
y1_hat = b(1) + b(2) * x1 + b(3) * x2 + b(4) * 0;
y2_hat = b(1) + b(2) * x1 + b(3) * x2 + b(4) * 1;

% 残差
e1 = y1 - y1_hat;
e2 = y2 - y2_hat;

% 绘制普通型汽车的散点图
figure(4);
subplot(2, 2, 1);
% scatter(x1, e1);
plot(x1, e1, 'b+', 'LineWidth', 1.5, 'MarkerSize', 8);
title('\bf普通型汽车: 残差与x1');
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$e_1$', 'Interpreter', 'latex');

subplot(2, 2, 2);
plot(x2, e1, 'b+', 'LineWidth', 1.5, 'MarkerSize', 8);
title('\bf普通型汽车: 残差与x2');
xlabel('$x_2$', 'Interpreter', 'latex');
ylabel('$e_1$', 'Interpreter', 'latex');

% 绘制豪华型汽车的散点图
subplot(2, 2, 3);
plot(x1, e2, 'r+', 'LineWidth', 1.5, 'MarkerSize', 8);
title('\bf豪华型汽车: 残差与x1');
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$e_2$', 'Interpreter', 'latex');

subplot(2, 2, 4);
plot(x2, e2, 'r+', 'LineWidth', 1.5, 'MarkerSize', 8);
title('\bf豪华型汽车: 残差与x2');
xlabel('$x_2$', 'Interpreter', 'latex');
ylabel('$e_2$', 'Interpreter', 'latex');

%% (4)增加二次项和交叉项
x1_sq = x1_all .^ 2;
x2_sq = x2_all .^ 2;
x1x2 = x1_all .* x2_all;
x1x3 = x1_all .* x3;
x2x3 = x2_all .* x3;

stepwise([x1_all, x2_all, x3, x1_sq, x2_sq, x1x2, x1x3, x2x3], y_all);

function dispModel(b, bint, stats)
    for i = 1:length(b)
        fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, b(i), bint(i,1), bint(i,2));
    end
    fprintf('R^2 = %.4f\n', stats(1));
    fprintf('F = %.4f\n', stats(2));
    fprintf('p = %.4e\n', stats(3));
    fprintf('S_e^2 = %.4f\n\n', stats(4));
end
