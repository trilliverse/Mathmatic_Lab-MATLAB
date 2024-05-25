t = [0 30];
x0 = [0.12; 0.003; 0.01];
[t1, x1] = ode45(@ODE, t, x0);

t = [0 133];
x0 = [0.01; 0.00001; 0.001];
[t2, x2] = ode45(@ODE, t, x0);

% 第一组
figure;
plot(t1,x1(:,1));
hold on;
plot(t1,x1(:,2));
plot(t1,x1(:,3));
hold off;
legend('x(t)','y(t)','z(t)');
xlabel('t')
ylabel('x,y,z');

% 第二组
figure;
plot(t2,x2(:,1));
hold on;
plot(t2,x2(:,2));
plot(t2,x2(:,3));
hold off;
legend('x(t)', 'y(t)', 'z(t)');
xlabel('t')
ylabel('x,y,z');

function dxdt = ODE(t, x)
    dxdt = zeros(3,1);
    dxdt(1)=x(1)*(1-x(1)-x(2)-6*x(3));
    dxdt(2)=x(2)*(1.5*x(1)-x(2)-x(3));
    dxdt(3)=x(3)*(-1+3*x(1)+0.5*x(2));
end