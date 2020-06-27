clear all
close all
clc
%% parameter
Q = [0.01 0 0; 0 0.02 0; 0 0 0.02]*10^-7;
R = [0.01 0 0; 0 0.02 0; 0 0 0.02]*10^-7;
r = [1000 9000];
V_theta = [-200 0 200];
V_phi = [-200 0 200];
phi = [-pi/3, pi/3];

count = 1;
for i = r
    for j = V_theta
        for k = V_phi
            for l = phi
                eval(['A' num2str(count) '= fuzzy_A(i,j,k,l);'])
                count = count + 1;
            end
        end
    end
end

B = [zeros(3);-eye(3)];
D = [zeros(3);eye(3)];
L = [1 0 0 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
Q_p = L'*Q*L;

alpha = 0.00001;
alpha_2 = alpha*alpha;
rho = 10;
rho2 = rho*rho;
v = 100;
v_2 = v*v;


x0 = [4000 pi/3 pi/3 -500 200 300]';


%% LMI (24)

setlmis([]);
W = lmivar(1,[6,1]);
for i = 1:36
    eval(['Y',num2str(i),'=lmivar(2,[3,6]);'])
end

for i = 1:36
    eval(['lmiterm([' num2str(i) ',1,1,W],A' num2str(i) ',1,"s");'])
    eval(['lmiterm([' num2str(i) ',1,1,Y' num2str(i) '],B,1,"s");'])
    eval(['lmiterm([' num2str(i) ',1,1,0], eye(6)+D*transpose(D)/rho2);'])
    eval(['lmiterm([' num2str(i) ',2,1,W],1,1);'])
    eval(['lmiterm([' num2str(i) ',2,2,0],-inv(alpha_2*eye(6)+Q_p))'])
    eval(['lmiterm([' num2str(i) ',3,1,Y' num2str(i) '],1,1);'])
    eval(['lmiterm([' num2str(i) ',3,3,0],-inv(R))'])
end

lmiterm([-37,1,1,W],1,1);

lmiterm([-38,1,1,0],1);
lmiterm([-38,2,1,0],x0);
lmiterm([-38,2,2,W],1,1);

% for i = 39:74
%     eval(['lmiterm([-' num2str(i) ',1,1,0],v_2)'])
%     eval(['lmiterm([-' num2str(i) ',1,2,Y' num2str(i-38) '],1,1);'])
%     eval(['lmiterm([-' num2str(i) ',2,2,W],1,1);'])
% end

lmisys1 = getlmis;
[tmin1, xfeas1] = feasp(lmisys1);

W = dec2mat(lmisys1,xfeas1,W);
P = inv(W);
for i=1:36
    eval(['Y' num2str(i) '=dec2mat(lmisys1,xfeas1,Y' num2str(i) ');'])
    eval(['K' num2str(i) '= Y' num2str(i) '*P;'])
end

%% Membership function
B(4,1) = 0;
X = zeros(6,1501);
X(:,1) = x0;
step_size = 0.01;
count = 1;
for t = 0:step_size:15
    dx = zeros(6,1);
    H_weighting = defuzzy(X(:,count));
    for i = 1:36
        for j = 1:36
            eval(['temp = Runge_Kutta_4th(A' num2str(i) ',B,K' num2str(j) ',D,X(:,count),step_size,t);']);
            dx = dx + H_weighting(i)*H_weighting(j)*temp;
        end
    end
    X(:,count+1) = X(:,count) + dx;
    if(X(:,count+1) <=50)
        break;
    end
    count = count + 1;
end

save data.mat
%% Plot Trajectory

tt = 0:step_size:t;

figure(1)
plot(tt,X(1,1:1242))
legend('r')
title('r state trajectory')
ylabel('r state value')
xlabel('Time t')
saveas(gcf, 'r2 state trajectory.png')
grid on

figure(2)
plot(tt,X(2,1:1242))
legend('theta')
title('theta state trajectory')
ylabel('theta state value')
xlabel('Time t')
saveas(gcf, 'theta2 state trajectory.png')
grid on

figure(3)
plot(tt,X(3,1:1242))
legend('phi')
title('phi state trajectory')
ylabel('phi state value')
xlabel('Time t')
saveas(gcf, 'phi2 state trajectory.png')
grid on

figure(4)
plot(tt,X(4,1:1242))
legend('V_r')
title('V_r state trajectory')
ylabel('V_r state value')
xlabel('Time t')
saveas(gcf, 'V_r2 state trajectory.png')
grid on

figure(5)
plot(tt,X(5,1:1242))
legend('V_theta')
title('V_theta state trajectory')
ylabel('V_theta state value')
xlabel('Time t')
saveas(gcf, 'V_theta2 state trajectory.png')
grid on

figure(6)
plot(tt,X(6,1:1242))
legend('V_phi')
title('V_phi state trajectory')
ylabel('V_phi state value')
xlabel('Time t')
saveas(gcf, 'V_phi2 state trajectory.png')
grid on







