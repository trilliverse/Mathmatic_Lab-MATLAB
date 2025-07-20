clc,clear
%% 数据
y = [11.2, 13.4, 40.7, 5.3, 24.8, 12.7, 20.9, 35.7, 8.7, 9.6, ...
    14.5, 26.9, 15.7, 36.2, 18.1, 28.9, 14.9, 25.8, 21.7, 25.7]';
x1 = [16.5, 20.5, 26.3, 16.5, 19.2, 16.5, 20.2, 21.3, 17.2, 14.3, ...
    18.1, 23.1, 19.1, 24.7, 18.6, 24.9, 17.9, 22.4, 20.2, 16.9]';
x2 = [6.2, 6.4, 9.3, 5.3, 7.3, 5.9, 6.4, 7.6, 4.9, 6.4, ...
    6.0, 7.4, 5.8, 8.6, 6.5, 8.4, 6.7, 8.6, 8.4, 6.7]';
x3 = [587, 643, 635, 692, 1248, 643, 1964, 1531, 713, 749, ...
    7895, 762, 2793, 741, 625, 854, 716, 921, 595, 3353]';
%% 散点图
figure(1);
scatter(x1, y, 'b', 'filled');
xlabel('\bf年收入低于5000$家庭的百分比');
ylabel('\bf犯罪率');

figure(2);
scatter(x2, y, 'b', 'filled');
xlabel('\bf失业率');
ylabel('\bf犯罪率');

figure(3);
scatter(x3, y, 'b', 'filled');
xlabel('\bf人口总数（千人）');
ylabel('\bf犯罪率');

%% （1）双变量回归模型
% % 使用regress函数（可取消注释以运行）
% X_12 = [ones(size(y)) x1 x2];
% [b_12, bint_12, r_12, rint_12, stats_12] = regress(y, X_12);
% 
% X_13 = [ones(size(y)) x1 x3];
% [b_13, bint_13, r_13, rint_13, stats_13] = regress(y, X_13);
% 
% X_23 = [ones(size(y)) x2 x3];
% [b_23, bint_23, r_23, rint_23, stats_23] = regress(y, X_23);
%
% fprintf('模型y ~ x1 + x2:\n');
% dispModel(b_12, bint_12, stats_12);
% fprintf('模型y ~ x1 + x3:\n');
% dispModel(b_13, bint_13, stats_13);
% fprintf('模型y ~ x2 + x3:\n');
% dispModel(b_23, bint_23, stats_23);

% 使用fitlm函数
tbl = table(y, x1, x2, x3);

% 模型1: y ~ x1 + x2
mdl_12 = fitlm(tbl, 'y ~ x1 + x2');
disp(mdl_12);
disp(' ');
% 提取回归系数及其置信区间
coeffs_12 = mdl_12.Coefficients.Estimate;
CI_12 = mdl_12.coefCI; % (since R2023a)
for i = 1:length(coeffs_12)
    fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, coeffs_12(i), CI_12(i,1), CI_12(i,2));
end

% 模型2: y ~ x1 + x3
mdl_13 = fitlm(tbl, 'y ~ x1 + x3');
disp(mdl_13);
disp(' ');
coeffs_13 = mdl_13.Coefficients.Estimate;
CI_13 = mdl_13.coefCI; % (since R2023a)
for i = 1:length(coeffs_13)
    fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, coeffs_13(i), CI_13(i,1), CI_13(i,2));
end

% 模型3: y ~ x2 + x3
mdl_23 = fitlm(tbl, 'y ~ x2 + x3');
disp(mdl_23);
disp(' ');
coeffs_23 = mdl_23.Coefficients.Estimate;
CI_23 = mdl_23.coefCI; % (since R2023a)
for i = 1:length(coeffs_23)
    fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, coeffs_23(i), CI_23(i,1), CI_23(i,2));
end

% 模型的性能指标
% R_square
R2_12 = mdl_12.Rsquared.Ordinary;
R2_13 = mdl_13.Rsquared.Ordinary;
R2_23 = mdl_23.Rsquared.Ordinary;
% Adjusted R_square
R2a_12 = mdl_12.Rsquared.Adjusted;
R2a_13 = mdl_13.Rsquared.Adjusted;
R2a_23 = mdl_23.Rsquared.Adjusted;
% RMSE
Se_12 = mdl_12.RMSE;
Se_13 = mdl_13.RMSE;
Se_23 = mdl_23.RMSE;
% F-value
F_12 = mdl_12.ModelFitVsNullModel.Fstat;
F_13 = mdl_13.ModelFitVsNullModel.Fstat;
F_23 = mdl_23.ModelFitVsNullModel.Fstat;

R2 = [R2_12, R2_13, R2_23];
R2a = [R2a_12, R2a_13, R2a_23];
Se = [Se_12, Se_13, Se_23];
F_value = [F_12, F_13, F_23];

%% 绘制双变量模型指标比较条形图
metrics = [R2; R2a; Se; F_value]; % 指标
metric_names = {'R^2', '调整R^2', 'S_e', 'F-value'};
% model_names = {'模型1: y ~ x1 + x2', '模型2: y ~ x1 + x3', '模型3: y ~ x2 + x3'};
model_names = {'Model 1: $y \sim x1 + x2$', 'Model 2: $y \sim x1 + x3$', 'Model 3: $y \sim x2 + x3$'};

figure(4);
% 设置左侧纵轴
yyaxis left;
b1 = bar(1:2, metrics(1:2,:));
ylabel('\bf数值', 'FontSize', 12);
ylim([0, 1]);
set(gca, 'YColor', 'k');

% 设置右侧纵轴
yyaxis right;
b2 = bar(3:4, metrics(3:4,:));
ylabel('\bf数值', 'FontSize', 12);
set(gca, 'YColor', 'k');

title('\bf三种双变量模型的四种指标比较', 'FontSize', 13);
xlabel('\bf指标', 'FontSize', 12);
set(gca, 'XTick', 1:4, 'XTickLabel', metric_names);
legend(model_names, 'Location', 'northwest', 'Interpreter', 'latex');
grid on;

set(b1(1), 'FaceColor', [0.76, 0.51, 0.49]);
set(b1(2), 'FaceColor', [0.47, 0.62, 0.77]);
set(b1(3), 'FaceColor', [0.88, 0.68, 0.50]);
set(b2(1), 'FaceColor', [0.76, 0.51, 0.49]);
set(b2(2), 'FaceColor', [0.47, 0.62, 0.77]);
set(b2(3), 'FaceColor', [0.88, 0.68, 0.50]);

% 最佳双变量模型
best_mdl = mdl_12;
best_mdl_name = 'y ~ x1 + x2';
disp(' ');
disp(['最佳双变量回归模型为: ', best_mdl_name]);
% disp(best_mdl);

%% (2) 三变量回归模型
mdl_123 = fitlm(tbl, 'y ~ x1 + x2 + x3');
disp(mdl_123);
disp(' ');
coeffs_123 = mdl_123.Coefficients.Estimate;
CI_123 = mdl_123.coefCI; % (since R2023a)

for i = 1:length(coeffs_123)
    fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, coeffs_123(i), CI_123(i,1), CI_123(i,2));
end

% 三变量模型性能指标
R2_123 = mdl_123.Rsquared.Ordinary;  % R_square
R2a_123 = mdl_123.Rsquared.Adjusted; % Adjusted R_square
Se_123 = mdl_123.RMSE;               % RMSE
F_123 = mdl_123.ModelFitVsNullModel.Fstat; % F-value

final_mdl = mdl_12;
final_mdl_name = 'y ~ x1 + x2';
disp(' ');
disp(['最终模型为: ', final_mdl_name]);
% disp(final_mdl);

%% (3)残差与离群分析
e = final_mdl.Residuals.Raw; % 残差

figure(5);
plotResiduals(final_mdl, 'fitted', 'MarkerSize', 8, 'LineWidth',1.5);
title('\bf最终模型的拟合值-残差值图', 'FontSize', 13);
xlabel('\bf拟合值');
ylabel('\bf残差值');

% 识别异常点
outliers = abs(e) > 2 * std(e);

if any(outliers)
    disp(' ');
    disp('存在异常点:');
    disp(find(outliers));
    
    % 剔除异常点
    y_clean = y(~outliers);
    x1_clean = x1(~outliers);
    x2_clean = x2(~outliers);
    x3_clean = x3(~outliers);
    
    % 重新回归分析
    tbl_clean = table(y_clean, x1_clean, x2_clean, x3_clean);
    final_mdl_clean = fitlm(tbl_clean, 'y_clean ~ x1_clean + x2_clean');
    
    disp('剔除异常点后的最终模型:');
    disp(final_mdl_clean);
    disp(' ');
    coeffs_clean = final_mdl_clean.Coefficients.Estimate;
    CI_clean = final_mdl_clean.coefCI; % (since R2023a)
    
    for i = 1:length(coeffs_clean)
        fprintf('回归系数 β_%d: %.4f, 置信区间: [%.4f, %.4f]\n', i-1, coeffs_clean(i), CI_clean(i,1), CI_clean(i,2));
    end

    Se_clean = final_mdl_clean.RMSE;
    F_clean = final_mdl_clean.ModelFitVsNullModel.Fstat;
    
    X_clean = [ones(size(y_clean)), x1_clean, x2_clean];
    [~, ~, r_clean, rint_clean, ~] = regress(y_clean, X_clean);
    figure(6);
    rcoplot(r_clean, rint_clean);
    
    e_clean = final_mdl_clean.Residuals.Raw;
    % Q-Q图
    figure(7);
    h = qqplot(e_clean);
    set(h(1), 'Marker', 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
    set(h(2), 'Color', 'r', 'LineWidth', 2); % 对角线

    % 逐步回归
    x_clean = [x1_clean, x2_clean, x3_clean];
    stepwise(x_clean, y_clean);
else
    disp('没有检测到明显的异常点');
end