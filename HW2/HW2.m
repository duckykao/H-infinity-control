clear all
close all
clc
%% Initial parameters

A = [1 0; 2 1];
B = [0.5; 1];
C1 = [0.5 0; 0 0.1];
C2 = [0.1 0; 0 0.2];
D = [0 1];
Q1 = eye(2);
Q2 = 4*eye(2);
R = 1;

x0 = [10;20];
max_rho = 5000;
max_gamma = 5000;

[P2,L,P1,K,rho,gamma] = mix_H2_Hinf(x0, max_rho, max_gamma,A,B,C1,C2,D,Q1,Q2,R);
clc
disp("initial value")
disp(x0)
disp("minimum gamma we can reach")
disp(gamma)
disp("minimmum rho we can reach")
disp(rho)

%% Augmented matrix
A_hat = [A+B*K -B*K; zeros(2) A-L*D];
C1_hat = [C1 zeros(2);C1 zeros(2)];
C2_hat = [C2 zeros(2);C2 zeros(2)];
L_hat = [eye(2) zeros(2,1); eye(2) -L];

save data
%% Runge_Kutta_4th method

step_size = 0.001;
total_pts = 10000;
X = Runge_Kutta_4th(x0, A_hat, C1_hat, C2_hat, L_hat, step_size, total_pts);

figure(1)
X_hat = X(1:2,:)+X(3:4,:);
tt = (0:step_size:10);
plot(tt,X(1,:),'r',tt,X(2,:),'g',tt,X_hat(1,:),'b',tt,X_hat(2,:),'black')
title('State trajectory - (Solution with RK4)');
xlabel('Time t');
ylabel('Solution x');
legend('x_1','x_2','x_1 hat','x_2 hat')
grid on
saveas(gcf,'State trajectory - (Solution with RK4).png')

figure(2)
plot(tt,X(3,:),'r',tt,X(4,:),'b')
title('Error trajectory - (Solution with RK4)');
xlabel('Time t');
ylabel('Error');
legend('x_1 error','x_2 error')
grid on
saveas(gcf,'Error trajectory - (Solution with RK4).png')

%% System Trajectory without using Runge Kutta

X = System_Trajectory(x0, A_hat, C1_hat, C2_hat, L_hat, step_size, total_pts, 1);

figure(3)
X_hat = X(1:2,:)+X(3:4,:);
tt = (0:step_size:10);
plot(tt,X(1,:),'r',tt,X(2,:),'g',tt,X_hat(1,:),'b',tt,X_hat(2,:),'black')
title('State trajectory - (Solution without RK4)');
xlabel('Time t');
ylabel('Solution x');
legend('x_1','x_2','x_1 hat','x_2 hat')
grid on
saveas(gcf,'State trajectory - (Solution without RK4).png')

figure(4)
plot(tt,X(3,:),'r',tt,X(4,:),'b')
title('Error trajectory - (Solution without RK4)');
xlabel('Time t');
ylabel('Error');
legend('x_1 error','x_2 error')
grid on
saveas(gcf,'Error trajectory - (Solution without RK4).png')
%% System Trajectory without using Runge Kutta also without external disturbance

X = System_Trajectory(x0, A_hat, C1_hat, C2_hat, L_hat, step_size, total_pts, 0);

figure(5)
X_hat = X(1:2,:)+X(3:4,:);
tt = (0:step_size:10);
plot(tt,X(1,:),'r',tt,X(2,:),'g',tt,X_hat(1,:),'b',tt,X_hat(2,:),'black')
title('State trajectory - (Solution without RK4 and external disturbance)');
xlabel('Time t');
ylabel('Solution x');
legend('x_1','x_2','x_1 hat','x_2 hat')
grid on
saveas(gcf,'State trajectory - (Solution without RK4 and external disturbance).png')

figure(6)
plot(tt,X(3,:),'r',tt,X(4,:),'b')
title('Error trajectory - (Solution without RK4 and external disturbance)');
xlabel('Time t');
ylabel('Error');
legend('x_1 error','x_2 error')
grid on
saveas(gcf,'Error trajectory - (Solution without RK4 and external disturbance).png')
%%



