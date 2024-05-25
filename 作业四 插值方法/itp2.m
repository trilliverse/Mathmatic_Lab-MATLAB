function itp2(n)
    x = linspace(-5, 5, n);
    f = @(x)1./(1+x.^2);
    fx = 1./(1+x.^2);
    
    xi = linspace(-5, 5, 101);
    y = f(xi);
    yi = itp1(x', fx', xi);
    plot(xi, y, 'b-', 'LineWidth', 1);
    hold on
    plot(xi, yi, 'r--');
    plot(x, fx, 'k*', 'MarkerSize', 10);
    legend("原始数据", "插值数据");
    hold off