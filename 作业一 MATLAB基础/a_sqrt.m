function x = a_sqrt(a)
    x0 = a / 2;
    while true
        x = 0.5 * (x0 + a / x0);
        if abs(x - x0) < 1e-5
            break;
        end
        x0 = x;
    end
end
