function output = target_acceleration(t,x)

lambda = 4*rand(1)*9.8;
omega = 20;
d_theta = x(5)/(x(1)*cos(x(3)));
d_phi = x(6)/x(1);

w_r = 1;
w_theta = (-d_phi)/sqrt(d_phi*d_phi+d_theta*cos(x(3))*cos(x(3)));
w_phi = d_theta*cos(x(3))/sqrt(d_phi*d_phi+d_theta*cos(x(3))*cos(x(3)));
output = lambda*sin(omega*t)*[w_r w_theta w_phi]';

end