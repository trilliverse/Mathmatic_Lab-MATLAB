function yi = itp1(x, y ,xi)
vx = vander(x);
ai = vx \ y;
yi = polyval(ai, xi);
end