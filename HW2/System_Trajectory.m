%% Run the State Trajectory without using any smoothing method
%  input : initial value x0, Augmented variables A_hat, C1_hat, C2_hat, L_hat
%          step size h, total points num, external disturbance H2 (if H2=1 we consider external disturbance)
%  ouput : system trajectory

function X = System_Trajectory(x0, A_hat, C1_hat, C2_hat, L_hat, h, num, H2)

v_hat = [sin(h:h:10);cos(h:h:10);0.01*randn(1,num)]*H2;
wiener1 = 0.01*randn(1,num);
wiener2 = 0.01*randn(1,num);
X = zeros(4,num+1);
X(:,1) = [x0;0;0];

for i = 2:num+1
    cur_x = X(:,i-1);
    dx = (A_hat*cur_x+L_hat*v_hat(:,i-1))*h+C1_hat*cur_x*wiener1(i-1)+C2_hat*cur_x*wiener2(i-1);
    X(:,i) = cur_x+dx;
end
end