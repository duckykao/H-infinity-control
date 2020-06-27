%% Run the State Trajectory  using any Runge Kutta 4th order method
%  input : initial value x0, Augmented variables A_hat, C1_hat, C2_hat, L_hat
%          step size h, total points num
%  ouput : system trajectory

function X = Runge_Kutta_4th(x0, A_hat, C1_hat, C2_hat, L_hat, h, num)

t = (h:h:10);
X = zeros(4,num+1);
X(:,1) = [x0;0;0];

for i = 2:num+1
    cur_x = X(:,i-1);
    k1 = (A_hat*cur_x+L_hat*[sin(t(i-1));cos(t(i-1));0.01*randn])*h+C1_hat*cur_x*0.01*randn+C2_hat*cur_x*0.01*randn;
    k2 = (A_hat*(cur_x+k1*h/2)+L_hat*[sin(t(i-1)+h/2);cos(t(i-1)+h/2);0.01*randn])*h+C1_hat*(cur_x+k1*h/2)*0.01*randn+C2_hat*(cur_x+k1*h/2)*0.01*randn;
    k3 = (A_hat*(cur_x+k2*h/2)+L_hat*[sin(t(i-1)+h/2);cos(t(i-1)+h/2);0.01*randn])*h+C1_hat*(cur_x+k2*h/2)*0.01*randn+C2_hat*(cur_x+k2*h/2)*0.01*randn;
    k4 = (A_hat*(cur_x+k3*h)+L_hat*[sin(t(i-1)+h);cos(t(i-1)+h);0.01*randn])*h+C1_hat*(cur_x+k3*h)*0.01*randn+C2_hat*(cur_x+k3*h)*0.01*randn;
    dx = (k1+2*k2+2*k3+k4)/6;
    X(:,i) = cur_x+dx;
end
end