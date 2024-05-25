function dxdt = myODEs(t, x)
    dxdt = zeros(3,1);
    dxdt(1) = x(1) * (1 - x(1) - x(2) - 6*x(3));
    dxdt(2) = x(2) * (1.5*x(1) - x(2) - x(3));
    dxdt(3) = x(3) * (-1 + 3*x(1) + 0.5*x(2));
end