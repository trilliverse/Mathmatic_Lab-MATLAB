clc,clear
x1 = [0.2 0.5 0.8 1.0 1.0 1.4 1.8 2.0 2.0 2.5 2.5 2.7 3.0]';
y1 = [54 55 63 66 69 73 82 83 80 91 93 94 94]';
x2 = [0.2 0.4 0.7 1.0 1.0 1.3 1.5 1.8 2.0 2.0 2.4 2.8 3.0]';
y2 = [51 52 55 61 64 65 66 69 68 69 72 76 77]';

group1 = ones(size(x1));   % 高蛋白质组 group=1
group0 = zeros(size(x2));  % 低蛋白质组 group=0

% 合并数据
x = [x1; x2];
y = [y1; y2];
group = [group1; group0];

%% 虚拟变量模型
tbl_dummy = table(x, group, y);
mdl_dummy = fitlm(tbl_dummy, 'y ~ x + group');
disp('虚拟变量模型回归分析结果:');
disp(mdl_dummy);
disp(' ');

%% 交互项模型
tbl_interaction = table(x, group, y);
mdl_interaction = fitlm(tbl_interaction, 'y ~ x * group');
disp('交互项模型回归分析结果:');
disp(mdl_interaction);