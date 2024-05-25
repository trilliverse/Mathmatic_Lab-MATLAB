function chasing_boat
    % 设定参数
    a = 12; % 走私船沿x轴的速度
    v = 10; % 缉私舰的速度
    d = 50; % 缉私舰与走私船在y轴上的初始距离
    t = [0, 150];
    y0 = [0; d];

    % 设置ode选项
    options = odeset('Events', @(t, y) eventFunction(t, y, a));
    % 求解微分方程
    [T, Y, TE, YE, IE] = ode45(@(t, y) boatDynamics(t, y, a, v), t, y0, options);

    % 绘制轨迹
    figure;
    plot(Y(:,1), Y(:,2), 'b-', 'LineWidth', 2); hold on;
    plot(a*T, zeros(size(T)), 'r--', 'LineWidth', 2);
    xlabel('$x$', 'Interpreter', 'latex');
    ylabel('$y$', 'Interpreter', 'latex');
    title('缉私舰和走私船的追击轨迹');
    axis equal;
    grid on; grid minor;
    
    % 标注a, v, d的值
    text(20, 13, ['$a=$ ' num2str(a)], 'Interpreter','latex', 'FontSize', 12);
    text(20, 9, ['$v=$ ' num2str(v)], 'Interpreter','latex', 'FontSize', 12);
    text(20, 5, ['$d=$ ' num2str(d)], 'Interpreter','latex', 'FontSize', 12);
    % 终止事件，标出缉私舰追上走私船的位置
    if ~isempty(TE)
        endMarker = plot(YE(:,1), YE(:,2), 'ko', 'MarkerSize',7, 'LineWidth',2);
        legend(endMarker, {'起点和终点'});
        fprintf('追击时间： t = %.2f seconds.\n', TE);
    end
    legend('缉私舰轨迹', '走私船轨迹', '起点和终点', 'Location', 'best');
    
end

function dydt = boatDynamics(t, y, a, v)
    x = y(1);
    y = y(2);
    xt = a*t;
    yt = 0;
    
    dis = sqrt((xt - x)^2 + y^2);
    dxdt = v * (xt - x) / dis;
    dydt = v * (-y) / dis;
    dydt = [dxdt; dydt];
end

function [value,isterminal,direction] = eventFunction(t, y, a)
    value = y(1) - a*t;     
    isterminal = 1;         
    direction = 0;          
end
