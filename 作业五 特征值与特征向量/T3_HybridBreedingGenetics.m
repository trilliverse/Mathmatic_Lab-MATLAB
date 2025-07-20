clear, clc;
% 转移矩阵
P = [1, 1/2, 0; 
     0, 1/2, 1; 
     0, 0, 0];

[V, D] = eig(P);
steady_state = V(:,abs(diag(D)-1) < 1e-10);
steady_state = steady_state / sum(steady_state); % 归一化

fprintf('稳定分布状态:\n');
disp(steady_state);

X0 = [0.8; 0.2; 0]; % 初始分布比例
n = 20; % 迭代次数

Xi = zeros(3, n + 1);
distributions(:,1) = X0;

% 迭代计算
X = X0;
for i = 1 : n
    X_next = P * X; 
    X = X_next;
    distributions(:,i+1) = X;
end

X20 = distributions(:,21);
fprintf('20年后的分布为:\n');
disp(X20);

% 判断是否稳定
eps = 1e-5;
is_stable = all(abs(X20 - steady_state) < eps);
fprintf('20年后的分布是否已经趋于稳定：%s\n', string(is_stable));

figure;
hold on;
title('\bf基因型分布随迭代次数的变化');
xlabel('\bf迭代次数');
ylabel('\bf分布比例');
plot(0:n, distributions(1,:), 'r-', 'LineWidth', 2, 'DisplayName', 'AA 分布');
plot(0:n, distributions(2,:), 'b-', 'LineWidth', 2, 'DisplayName', 'Aa 分布');
plot(0:n, distributions(3,:), 'g-', 'LineWidth', 2, 'DisplayName', 'aa 分布');
legend('show');
grid on;
hold off;