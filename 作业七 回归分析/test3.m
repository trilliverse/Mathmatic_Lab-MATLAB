clc,clear
y1 = [22.1, 15.4, 11.7, 10.3, 11.4, 7.5, 13.0, 12.8, 14.6, 18.9, 19.3, 30.1, 28.2, 25.6, 37.5, 36.1, 39.8, 44.3]';
y2 = [7.2, 5.4, 7.6, 2.5, 2.4, 1.7, 4.3, 3.7, 3.9, 7.0, 6.8, 10.1, 9.4, 7.9, 14.1, 14.5, 14.9, 15.6]';
x1 = [1.89, 1.94, 1.95, 1.82, 1.85, 1.78, 1.76, 1.76, 1.75, 1.74, 1.70, 1.70, 1.68, 1.60, 1.61, 1.64, 1.67, 1.68]';
x2 = [6.1, 6.2, 6.3, 8.2, 9.8, 10.3, 10.5, 8.7, 7.4, 6.9, 5.2, 4.9, 4.3, 3.7, 3.6, 3.1, 1.8, 2.3]';

%% (1)独立模型
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

% %% 去除离群点重新回归分析
% % 普通型
% outlier_1 = false(size(y1, 1), 1);
% figure(1);
% rcoplot(r1, rint1);
% 
% % 剔除异常点14 18
% outlier_1([14 18]) = true;
% y1_clean = y1(~outlier_1);
% x1_clean_1 = x1(~outlier_1);
% x2_clean_1 = x2(~outlier_1);
% X1_clean = [ones(size(y1_clean)), x1_clean_1, x2_clean_1];
% [~, ~, r1_clean, rint1_clean, ~] = regress(y1_clean, X1_clean);
% figure(2);
% rcoplot(r1_clean, rint1_clean);
% 
% % 剔除异常点11
% outlier_1(11) = true;
% y1_clean = y1(~outlier_1);
% x1_clean_1 = x1(~outlier_1);
% x2_clean_1 = x2(~outlier_1);
% X1_clean = [ones(size(y1_clean)), x1_clean_1, x2_clean_1];
% [b1_clean, bint1_clean, r1_clean, rint1_clean, stats1_clean] = regress(y1_clean, X1_clean);
% figure(3);
% rcoplot(r1_clean, rint1_clean);
% 
% fprintf('普通型汽车销售量模型（剔除离群值后）:\n');
% dispModel(b1_clean, bint1_clean, stats1_clean);

%%
% % 豪华型
% outlier_2 = false(size(y2, 1), 1);
% figure(4);
% rcoplot(r2, rint2);

% % 剔除异常点14
% outlier_2(14) = true;
% y2_clean = y2(~outlier_2);
% x1_clean_2 = x1(~outlier_2);
% x2_clean_2 = x2(~outlier_2);
% X2_clean = [ones(size(y2_clean)), x1_clean_2, x2_clean_2];
% [~, ~, r2_clean, rint2_clean, ~] = regress(y2_clean, X2_clean);
% figure(5);
% rcoplot(r2_clean, rint2_clean);
% 
% % 剔除异常点7
% outlier_2(7) = true;
% y2_clean = y2(~outlier_2);
% x1_clean_2 = x1(~outlier_2);
% x2_clean_2 = x2(~outlier_2);
% X2_clean = [ones(size(y2_clean)), x1_clean_2, x2_clean_2];
% [~, ~, r2_clean, rint2_clean, ~] = regress(y2_clean, X2_clean);
% figure(6);
% rcoplot(r2_clean, rint2_clean);
% 
% % 剔除异常点11
% outlier_2(11) = true;
% y2_clean = y2(~outlier_2);
% x1_clean_2 = x1(~outlier_2);
% x2_clean_2 = x2(~outlier_2);
% X2_clean = [ones(size(y2_clean)), x1_clean_2, x2_clean_2];
% [b2_clean, bint2_clean, r2_clean, rint2_clean, stats2_clean] = regress(y2_clean, X2_clean);
% figure(7);
% rcoplot(r2_clean, rint2_clean);
% 
% fprintf('豪华型汽车销售量模型（剔除离群值后）:\n');
% dispModel(b2_clean, bint2_clean, stats2_clean);

%% (2)统一模型
x3 = [zeros(length(y1), 1); ones(length(y2), 1)];
y_all = [y1; y2];
x1_all = [x1; x1];
x2_all = [x2; x2];
X_all = [ones(length(x1_all), 1), x1_all, x2_all, x3];

[b, bint, r, rint, stats] = regress(y_all, X_all);
figure(3);
rcoplot(r, rint);
fprintf('统一模型:\n');
dispModel(b, bint, stats);

% outlier_all = false(size(y_all, 1), 1);
% % 剔除异常点18
% outlier_all(18) = true;
% y_clean = y_all(~outlier_all);
% x1_clean = x1_all(~outlier_all);
% x2_clean = x2_all(~outlier_all);
% x3_clean = x3(~outlier_all);
% X_clean = [ones(length(x1_clean), 1), x1_clean, x2_clean, x3_clean];
% [b_clean, bint_clean, r_clean, rint_clean, stats_clean] = regress(y_clean, X_clean);
% figure;
% rcoplot(r_clean, rint_clean);
% fprintf('剔除18 统一模型:\n');
% dispModel(b_clean, bint_clean, stats_clean);
% 
% % 剔除异常点15 17
% outlier_all([15 17]) = true;
% y_clean = y_all(~outlier_all);
% x1_clean = x1_all(~outlier_all);
% x2_clean = x2_all(~outlier_all);
% x3_clean = x3(~outlier_all);
% X_clean = [ones(size(y_clean)), x1_clean, x2_clean, x3_clean];
% [b_clean, bint_clean, r_clean, rint_clean, stats_clean] = regress(y_clean, X_clean);
% figure;
% rcoplot(r_clean, rint_clean);
% fprintf('剔除15 17 18 统一模型:\n');
% dispModel(b_clean, bint_clean, stats_clean);
% 
% % 剔除异常点12 16
% outlier_all([12 16]) = true;
% y_clean = y_all(~outlier_all);
% x1_clean = x1_all(~outlier_all);
% x2_clean = x2_all(~outlier_all);
% x3_clean = x3(~outlier_all);
% X_clean = [ones(size(y_clean)), x1_clean, x2_clean, x3_clean];
% [b_clean, bint_clean, r_clean, rint_clean, stats_clean] = regress(y_clean, X_clean);
% figure;
% rcoplot(r_clean, rint_clean);
% fprintf('剔除12 15 16 17 18 统一模型:\n');
% dispModel(b_clean, bint_clean, stats_clean);
% 
% % 剔除异常点1 13
% outlier_all([1 13]) = true;
% y_clean = y_all(~outlier_all);
% x1_clean = x1_all(~outlier_all);
% x2_clean = x2_all(~outlier_all);
% x3_clean = x3(~outlier_all);
% X_clean = [ones(size(y_clean)), x1_clean, x2_clean, x3_clean];
% [b_clean, bint_clean, r_clean, rint_clean, stats_clean] = regress(y_clean, X_clean);
% figure;
% rcoplot(r_clean, rint_clean);
% fprintf('剔除1 12 13 15 16 17 18统一模型:\n');
% dispModel(b_clean, bint_clean, stats_clean);

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
x1_sq = x1_all .^ 2;      % x4
x2_sq = x2_all .^ 2;      % x5
x1x2 = x1_all .* x2_all;  % x6
x1x3 = x1_all .* x3;      % x7
x2x3 = x2_all .* x3;      % x8

X = [x1_all, x2_all, x3, x1_sq, x2_sq, x1x2, x1x3, x2x3];

stepwise(X, y_all, [1 2 3]); % 逐步回归

% X_tmp = [ones(length(x1_all), 1), x1_all, x2_all, x3, x1_sq, x2_sq];
% X_tmp = [ones(length(x1_all), 1), x1_all, x2_all, x3, x1x2, x1x3, x2x3];
X_tmp = [ones(length(x1_all), 1), x1_all, x2_all, x3, x2_sq, x1x3, x2x3];
[b_tmp, bint_tmp, r_tmp, rint_tmp, stats_tmp] = regress(y_all, X_tmp);
dispModel(b_tmp, bint_tmp, stats_tmp);

