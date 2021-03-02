function  filter = simplefunction(sigma,ori,gamma,lambda,phi)

dy2 = 1.0 / (2 * sigma * sigma);
dx2 = 1.0 / (2 * sigma * sigma);

[x,y] = meshgrid(-4:4);

x2 = x.* cos(ori) + y.* sin(ori);
y2 = x.* sin(ori) - y.* cos(ori);

filter = exp(-(x2.* x2.* dx2 + (gamma * gamma).* y2.* y2.* dy2)).* cos((2 * pi).* x2 ./ lambda + phi);

end