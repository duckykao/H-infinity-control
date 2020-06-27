%% Run the State Trajectory  using any Runge Kutta 4th order method

function dx_aug = Runge_Kutta_4th(cur_x, t, A_ij, E_i)

h = 0.01;

v = [0;8*sin(t);0;8*cos(t)];
w = [0.1*randn(2,1); 0.1*randn(4,1); v];
k1 = A_ij*cur_x+E_i*w;

v = [0;8*sin(t+h/2);0;8*cos(t+h/2)];
w = [0.1*randn(2,1); 0.1*randn(4,1); v];
k2 = A_ij*(cur_x+k1*h/2)+E_i*w;

v = [0;8*sin(t+h/2);0;8*cos(t+h/2)];
w = [0.1*randn(2,1); 0.1*randn(4,1); v];
k3 = A_ij*(cur_x+k2*h/2)+E_i*w;

v = [0;8*sin(t+h);0;8*cos(t+h)];
w = [0.1*randn(2,1); 0.1*randn(4,1); v];
k4 = A_ij*(cur_x+k3*h)+E_i*w;

dx_aug = (k1+2*k2+2*k3+k4)*h/6;

end