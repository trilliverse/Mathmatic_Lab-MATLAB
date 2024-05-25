% 数据提取
years = 1990:2010;
population = [114333, 115823, 117171, 118517, 119850, 121121, 122389, 123626, ...
              124761, 125786, 126743, 127627, 128453, 129227, 129988, 130756, ...
              131448, 132129, 132802, 133450, 134091];
%% 人口统计年鉴
figure;
plot(years, population, 'bo-','LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b'); 
title('\bf人口统计年鉴', 'FontSize', 14);
xlabel('年份', 'FontSize', 12);
ylabel('人口数量 (万)', 'FontSize', 12);
xticks(1990:1:2010); % 设置x轴刻度为每年一个刻度
grid on; grid minor;

%% 定量分析人口增长规律（绘制表格）
% 计算每年的增长量
growth_amount = diff(population);
% 计算每年的增长率
growth_rate = (growth_amount ./ population(1:end-1)) * 100;
% 从第二年开始计算增长量
adjusted_years = years(2:end);

% 创建表格数据
growth_data = table(adjusted_years', growth_amount', growth_rate', ...
    'VariableNames', {'年份', '增长人口数量 (万)', '年增长率 (%)'});
% 将表格数据转换为单元数组
cell_data = table2cell(growth_data);
% 估计uitable需要的大小
table_height = 22 * (size(cell_data, 1) + 1);

% 创建figure窗口
fig = figure('Name', 'Population Growth Table', 'NumberTitle', 'off', ...
    'Position', [100, 100, 520, table_height + 50]);

% 显示表格，并调整uitable大小以展示所有数据
t = uitable('Parent', fig, ...
        'Data', cell_data, ...
        'ColumnName', growth_data.Properties.VariableNames, ...
        'RowName', [], ...
        'ColumnWidth', {80, 125, 80}, ...
        'Position', [20, 20, 480, table_height]);
%% 绘制增长量和增长率（可视化）
figure;
% 创建左侧 y 轴用于绘制增长量
yyaxis left;
plot(adjusted_years, growth_amount, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
ylabel('增长人口数量 (万)');

% 创建右侧 y 轴用于绘制增长率
yyaxis right;
plot(adjusted_years, growth_rate, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
ylabel('年增长率 (%)');

% 设置通用图表属性
title('\bf人口增长规律分析');
xlabel('年份');
xticks(1990:1:2010);
legend({'增长人口数量 (万)', '年增长率 (%)'}, 'Location', 'northeast');
grid on; grid minor;
%% 模型：线性回归预测
predicted_years = 2011:2012;
poly_order = 1; % 线性回归
p = polyfit(years, population, poly_order); % 线性回归拟合
% 使用拟合模型预测2011年和2012年的人口数量
predicted_2011 = polyval(p, 2011);
predicted_2012 = polyval(p, 2012);
predicted_population = [predicted_2011, predicted_2012];

% 输出预测结果
fprintf('Predicted population for 2011: %f\n', predicted_2011);
fprintf('Predicted population for 2012: %f\n', predicted_2012);

% 将预测值绘制在图表上
extended_years = 1990:2012; % 新的年份向量
% 计算预测人口数
extended_population = polyval(p, extended_years);

% 实际人口数量
actual_2011 = 134916;
actual_2012 = 135922;
actual_population = [actual_2011, actual_2012];

% 绘制原始数据和预测线
figure;
plot(years, population, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b'); % 实际人口数据
hold on; % 保持当前图表，以便在相同的图表上绘制更多的图形元素
plot(extended_years, extended_population, 'r-', 'LineWidth', 1.3); % 预测线
plot(predicted_years, predicted_population, 'gs', 'MarkerSize', 7.5, 'MarkerFaceColor', 'k');
plot(predicted_years, actual_population, 'bo', 'MarkerSize', 5.5, 'MarkerFaceColor','r');
hold off; % 不再保持当前图表

% 设置图表的标题和标签
title('\bf人口数量预测', 'FontSize', 14);
xlabel('年份', 'FontSize', 12);
ylabel('人口数量 (万)', 'FontSize', 12);
legend('实际人口数量', '线性预测', '预测人口数量', '实际人口数量(2011 & 2012)', 'Location', 'northwest');
xticks(1990:1:2012);
grid on; grid minor;

%% 模型：多项式拟合预测
poly_order = 6; % 拟合的多项式阶数
p = polyfit(years, population, poly_order);
% 使用拟合模型预测2011年和2012年的人口数量
predicted_2011 = polyval(p, 2011);
predicted_2012 = polyval(p, 2012);
predicted_population = [predicted_2011, predicted_2012];

% 由于使用高阶多项式，需要更多的点来平滑曲线
fine_grained_years = 1990:0.1:2012; % 使用更细的年份间隔来生成平滑的曲线
extended_population = polyval(p, fine_grained_years);

% 绘制原始数据和预测线
figure;
plot(years, population, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b'); % 实际人口数据
grid on; grid minor;
hold on;
plot(fine_grained_years, extended_population, 'r-', 'LineWidth', 1.3); % 高阶预测曲线
plot(predicted_years, predicted_population, 'gs', 'MarkerSize', 7.5, 'MarkerFaceColor', 'k'); % 预测人口数量
plot(predicted_years, actual_population, 'bo', 'MarkerSize', 5.5, 'MarkerFaceColor','r'); % 实际人口数量
hold off;

% 设置图表的标题和标签
title('\bf人口数量高阶多项式预测', 'FontSize', 14);
xlabel('年份', 'FontSize', 12);
ylabel('人口数量 (万)', 'FontSize', 12);
legend('实际人口数量', ['多项式预测(' num2str(poly_order) '阶)'], '预测人口数量', '实际人口数量(2011 & 2012)', 'Location', 'northwest');
xticks(1990:1:2012);
grid on; grid minor;

%% 模型评估
% 计算实际数据与预测数据的差异（残差）
residuals = [actual_2011 - predicted_2011, actual_2012 - predicted_2012];
% 计算均方误差 MSE
MSE = mean(residuals.^2);
% 计算总平方和 SST 和残差平方和 SSE
SST = sum((population - mean(population)).^2) + sum(([actual_2011, actual_2012] - mean([population, actual_2011, actual_2012])).^2);
SSE = sum(residuals.^2);
% 计算决定系数
R2 = 1 - (SSE / SST);

% 输出模型评估结果
fprintf('均方误差 (MSE): %f\n', MSE);
fprintf('决定系数 (R^2): %f\n', R2);

% 计算每个预测年份的相对误差百分比
relative_errors = abs(residuals) ./ [actual_2011, actual_2012] * 100;
% 计算平均相对误差百分比
average_relative_error = mean(relative_errors);
fprintf('平均相对误差百分比: %f%%\n', average_relative_error);
