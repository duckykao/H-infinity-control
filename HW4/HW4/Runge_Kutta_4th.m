function output = Runge_Kutta_4th(A,B,K,D,x,step_size,t)

lambda = 4*rand(1)*9.8;
omega = 20;
d_theta = x(5)/(x(1)*cos(x(3)));
d_phi = x(6)/x(1);

w_r = 1;
w_theta = (-d_phi)/sqrt(d_phi*d_phi+d_theta*d_theta*cos(x(3))*cos(x(3)));
w_phi = d_theta*cos(x(3))/sqrt(d_phi*d_phi+d_theta*d_theta*cos(x(3))*cos(x(3)));
w = D*[w_r w_theta w_phi]';

k1 = (A+B*K)*x+lambda*sin(omega*t)*w;
k2 = (A+B*K)*(x+k1*step_size/2)+lambda*sin(omega*t+step_size/2)*w;
k3 = (A+B*K)*(x+k2*step_size/2)+lambda*sin(omega*t+step_size/2)*w;
k4 = (A+B*K)*(x+k3*step_size)+lambda*sin(omega*t+step_size)*w;
output = (k1+k2+k3+k4)*step_size/6;

end