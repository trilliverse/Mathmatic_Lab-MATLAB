clc,clear
% 数据输入
y = [11.2, 13.4, 40.7, 5.3, 24.8, 12.7, 20.9, 35.7, 8.7, 9.6, ...
    14.5, 26.9, 15.7, 36.2, 18.1, 28.9, 14.9, 25.8, 21.7, 25.7]';
x1 = [16.5, 20.5, 26.3, 16.5, 19.2, 16.5, 20.2, 21.3, 17.2, 14.3, ...
    18.1, 23.1, 19.1, 24.7, 18.6, 24.9, 17.9, 22.4, 20.2, 16.9]';
x2 = [6.2, 6.4, 9.3, 5.3, 7.3, 5.9, 6.4, 7.6, 4.9, 6.4, ...
    6.0, 7.4, 5.8, 8.6, 6.5, 8.4, 6.7, 8.6, 8.4, 6.7]';

% 构建设计矩阵
X_12 = [ones(size(y)), x1, x2];

% 使用regress函数
[b_12, bint_12, r_12, rint_12, stats_12] = regress(y, X_12);

% 提取估计标准误差
Se_regress = sqrt(stats_12(4));

disp('Estimated Standard Error (Se) using regress:');
disp(Se_regress);

% 构建表格数据
tbl = table(y, x1, x2);

% 使用fitlm进行线性回归
mdl_12 = fitlm(tbl, 'y ~ x1 + x2');

% 提取估计标准误差（残差标准误差）
Se_fitlm = mdl_12.RMSE;

disp('Estimated Standard Error (RMSE) using fitlm:');
disp(Se_fitlm);
