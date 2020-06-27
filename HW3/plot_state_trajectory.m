function plot_state_trajectory(X, Xr)
step_size = 0.01;
tt = 0:step_size:30.01;
Error = X -Xr;

figure(1)
plot(tt,X(1,:),'r',tt,Xr(1,:),'b',tt,Error(1,:),'g')
legend('X_1', 'Xr_1','error')
title('X1 state trajectory')
ylabel('X1 state value')
xlabel('Time t')
saveas(gcf, 'X1 state trajectory.png')
grid on

figure(2)
plot(tt,X(2,:),'r',tt,Xr(2,:),'b',tt,Error(2,:),'g')
legend('X_2', 'Xr_2','error')
title('X2 state trajectory')
ylabel('X2 state value')
xlabel('Time t')
saveas(gcf, 'X2 state trajectory.png')
grid on

figure(3)
plot(tt,X(3,:),'r',tt,Xr(3,:),'b',tt,Error(3,:),'g')
legend('X_3', 'Xr_3','error')
title('X3 state trajectory')
ylabel('X3 state value')
xlabel('Time t')
saveas(gcf, 'X3 state trajectory.png')
grid on

figure(4)
plot(tt,X(4,:),'r',tt,Xr(4,:),'b',tt,Error(4,:),'g')
legend('X_4', 'Xr_4','error')
title('X4 state trajectory')
ylabel('X4 state value')
xlabel('Time t')
saveas(gcf, 'X4 state trajectory.png')
grid on
end