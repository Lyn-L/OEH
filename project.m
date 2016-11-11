function HH = project(X, R)

HH = [X * R];

HH(HH>0) = 1;
HH(HH<=0) = 0;

return;
