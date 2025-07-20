clc,clear
% 高蛋白质食物组数据
x1 = [0.2 0.5 0.8 1.0 1.0 1.4 1.8 2.0 2.0 2.5 2.5 2.7 3.0]';
y1 = [54 55 63 66 69 73 82 83 80 91 93 94 94]';

% 低蛋白质食物组数据
x2 = [0.2 0.4 0.7 1.0 1.0 1.3 1.5 1.8 2.0 2.0 2.4 2.8 3.0]';
y2 = [51 52 55 61 64 65 66 69 68 69 72 76 77]';

%% 绘制散点图
figure(1);
hold on;
scatter(x1, y1, 'b', 'filled');
scatter(x2, y2, 'r');
xlabel('\bf年龄（岁）');
ylabel('\bf身高（cm）');
legend('高蛋白质食物组', '低蛋白质食物组', 'Location', 'northwest');
title('\bf婴儿身高与年龄散点图', 'FontSize', 13);
hold off;

%% 计算相关系数和t检验
[R1, P1] = corrcoef(x1, y1);
[R2, P2] = corrcoef(x2, y2);

% 输出相关系数和p值
fprintf('高蛋白质组相关系数 r = %.4f, p = %.4e\n', R1(1,2), P1(1,2));
fprintf('低蛋白质组相关系数 r = %.4f, p = %.4e\n', R2(1,2), P2(1,2));

% t分布检验
n1 = length(x1);
n2 = length(x2);
t1 = R1(1,2) * sqrt((n1 - 2) / (1 - R1(1,2)^2));
t2 = R2(1,2) * sqrt((n2 - 2) / (1 - R2(1,2)^2));
p1 = 2 * (1 - tcdf(abs(t1), n1 - 2));
p2 = 2 * (1 - tcdf(abs(t2), n2 - 2));

fprintf('高蛋白质食物组 t = %.4f, p = %.4e\n', t1, p1);
fprintf('低蛋白质食物组 t = %.4f, p = %.4e\n\n', t2, p2);

%% 回归分析
X1 = [ones(length(x1), 1), x1];
[b_high, bint_high, r1, rint_high, stats_high] = regress(y1, X1);

X2 = [ones(length(x2), 1), x2];
[b_low, bint_low, r2, rint_low, stats_low] = regress(y2, X2);

fprintf('高蛋白质组回归模型:\n');
dispModel(b_high, bint_high, stats_high);

fprintf('低蛋白质组回归模型:\n');
dispModel(b_low, bint_low, stats_low);

% 回归方程
fprintf('高蛋白质组回归方程: y = %.4f + %.4fx\n', b_high(1), b_high(2));
fprintf('低蛋白质组回归方程: y = %.4f + %.4fx\n', b_low(1), b_low(2));

%% 离群分析
figure(2);
rcoplot(r1, rint_high);
figure(3);
rcoplot(r2, rint_low);

contain0_high = (rint_high(:,1)<0 & rint_high(:,2)>0);
idx_high = find(contain0_high==false);
contain0_low = (rint_low(:,1)<0 & rint_low(:,2)>0);
idx_low = find(contain0_low==false);

% 标记离群点
figure(4)
hold on
scatter(x1, y1, 'b');
scatter(x2, y2, 'r');
scatter(x1(idx_high), y1(idx_high), 'b','filled');
scatter(x2(idx_low), y2(idx_low), 'r','filled');
xlabel('年龄（岁）');
ylabel('身高（cm）');
title('\bf高蛋白质组和低蛋白质组身高与年龄的离群点标记', 'FontSize', 13);
legend({'高蛋白质组数据点', '低蛋白质组数据点', '高蛋白质组离群点', '低蛋白质组离群点'}, 'Location', 'northwest');
hold off

% 回归直线
y_hat_high = b_high(1) + b_high(2) * x1;
y_hat_low = b_low(1) + b_low(2) * x2;

figure(5);
hold on;
scatter(x1, y1, 'b', 'filled');
scatter(x2, y2, 'r');
plot(x1, y_hat_high, 'b--', 'LineWidth', 1.8);
plot(x2, y_hat_low, 'r--', 'LineWidth', 1.8);
xlabel('年龄（岁）');
ylabel('身高（cm）');
legend('高蛋白质组', '低蛋白质组', '高蛋白质回归直线', '低蛋白质回归直线', 'Location', 'northwest');
title('\bf回归直线', 'FontSize', 13);
hold off;

%% 模型有效性检验
% 拟合优度检验
fprintf('高蛋白质组-决定系数 R^2 = %.4f\n', stats_high(1));
fprintf('低蛋白质组-决定系数 R^2 = %.4f\n', stats_low(1));
fprintf('高蛋白质组-标准误差 s = %.4f\n', sqrt(stats_high(4)));
fprintf('低蛋白质组-标准误差 s = %.4f\n', sqrt(stats_low(4)));

% 显著性检验
% 回归系数检验（F检验）：
fprintf('高蛋白质组 F = %.4f, p = %.4e\n', stats_high(2), stats_high(3));
fprintf('低蛋白质组 F = %.4f, p = %.4e\n', stats_low(2), stats_low(3));