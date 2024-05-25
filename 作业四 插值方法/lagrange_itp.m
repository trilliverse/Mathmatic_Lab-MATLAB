function yi = lagrange_itp(x, y, xi)
    vx = vander(x);
    ai = vx \ y';
    yi = polyval(ai, xi);
end