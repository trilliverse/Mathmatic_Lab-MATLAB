clear, clc
% 确定画图范围
a = 0;
b = 2000;
c = 0;
d = 2000;

n = 100; % 迭代次数
% xlabel('$|\lambda|=1,|u|<1$', 'Interpreter', 'latex');
xlabel('$|\lambda|>1,|u|<1$', 'Interpreter', 'latex');
axis([a b c d]); 
grid on;
hold on
x = linspace(a, b, 30);

p = 0.125; % 捕食参数
% A = [0.5, 0.4; -p, 1.1]; % 状态矩阵
A = [0.5, 0.4; -p, 1.2]; % 状态矩阵轻微变动分析
[pc, lambda] = eig(A); % 特征值与特征向量
lambda_values = diag(lambda);
abs_lambda = abs(lambda_values);

% 可视化特征向量
[Y, I] = sort(abs_lambda, 'descend'); % 绝对值降序
lambda = lambda_values(I);
pc = pc(:, I);
pc = -pc;
disp("lambda = "); disp(lambda); 
disp("pc = "); disp(pc);
v1 = pc(2, 1) / pc(1, 1) * x;
v2 = pc(2, 2) / pc(1, 2) * x;

% 标注基向量的位置
h = plot(x, v1); 
set(h, 'LineWidth', 2); 
text(x(7), v1(7) - 100, '$v1$', 'Interpreter', 'latex');
h = plot(x, v2); 
set(h, 'LineWidth', 2); 
text(x(20), v2(20) - 100, '$v2$', 'Interpreter', 'latex');

button = 1;
while button == 1
    [xi, yi, button] = ginput(1); % 初始条件交互式输入
    plot(xi, yi, 'go'), hold on;
    X0 = [xi; yi];
    X = X0;
    for i = 1 : n
        X_next = A * X; % 计算下一个状态
        plot(X(1), X(2), 'r.', 'MarkerSize', 12); % 绘制当前点
        plot([X(1), X_next(1)], [X(2), X_next(2)], 'r-'); % 绘制线段
        text(X0(1,1), X0(2,1)-30, '$x0$', 'Interpreter', 'latex');
        quiver(X(1), X(2), X_next(1) - X(1), X_next(2) - X(2), 1, 'b', 'LineWidth', 1, 'MaxHeadSize', 0.5); % 绘制箭头
        X = X_next; % 更新状态
    end
end