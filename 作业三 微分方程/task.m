function task
    % 设定参数
    a = 5; 
    v = 15;
    d = 20;
    t = [0, 150];
    y0 = [0; d];

    options = odeset('Events', @(t, y) event(t, y, a));
    [T, Y, ~, ~, ~] = ode45(@(t, y) solve(t, y, a, v), t, y0, options);

    figure;
    plot(Y(:,1), Y(:,2)); 
    hold on;
    plot(a*T, zeros(size(T)));
    grid on;
end

function dydt = solve(t, y, a, v)
    x = y(1);
    y = y(2);
    xt = a*t;
    yt = 0;
    
    dis = sqrt((xt - x)^2 + y^2);
    dxdt = v * (xt - x) / dis;
    dydt = v * (-y) / dis;
    dydt = [dxdt; dydt];
end

function [value,isterminal,direction] = event(t, y, a)
    value = y(1) - a*t;     
    isterminal = 1;         
    direction = 0;          
end
