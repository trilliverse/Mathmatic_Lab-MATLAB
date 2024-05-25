N = 10000; % 设置数列项数

% 调用函数计算部分和数列
S_n = harmonic_partial_sum_1(N);
S_2n = harmonic_partial_sum_1(2*N);
%% 绘制部分和数列{S_n}折线图
figure;
plot(1:N, S_n, 'b-', 'LineWidth', 2)
grid on; grid minor;
xlabel('${n}$', 'Interpreter', 'latex')
ylabel('${S_n}$', 'Interpreter', 'latex')
title('部分和数列');
%% 绘制{H_n}:H(n)=S(2n)-S(n)折线图
figure;
H_n = S_2n(2:2:end) - S_n;
% 绘制 H_n 的折线图
plot(1:N, H_n, 'r-', 'LineWidth', 2);
grid on; grid minor;
xlabel('${n}$', 'Interpreter', 'latex');
ylabel('${H_n}$', 'Interpreter', 'latex');
title('${\{H_n\}:H_n = S_{2n}-S_n}$', 'Interpreter', 'latex');
%% 绘制{G_n}:G(n)=S(2n)并函数拟合
G_n = S_2n(2:2:end);
% 绘制 G_n 的折线图
figure;
plot(1:N, G_n, 'bo', 'LineWidth', 2, 'MarkerSize', 4);
grid on; grid minor;
xlabel('${n}$', 'Interpreter', 'latex');
ylabel('${G_n}$', 'Interpreter', 'latex');
title('${\{G_n\}:G_n = S_{2n}}$', 'Interpreter', 'latex');

% 使用对数函数进行拟合
coefficients = polyfit(log(1:N), G_n, 1);
a = coefficients(1);
b = coefficients(2);
% 计算拟合值
G_fit = a * log(1:N) + b;

% 绘制拟合曲线
hold on;
plot(1:N, G_fit, 'r-', 'LineWidth', 2);
legend('实际值', '拟合曲线', 'Location', 'southeast');
hold off;

%% 定义求解调和级数部分和的函数
% 法1：使用内置函数实现
function S_n = harmonic_partial_sum_1(N)
    S_n = cumsum(1./(1:N));
end
% 法2：使用循环实现
function S_n = harmonic_partial_sum_2(N)
    S_n = zeros(1, N);  
    partial_sum = 0;    

    for n = 1:N
        partial_sum = partial_sum + 1/n; 
        S_n(n) = partial_sum;
    end
end
