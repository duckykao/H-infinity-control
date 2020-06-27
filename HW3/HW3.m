clear all
close all
clc
%% parameter
m1 = 3;
m2 = 2;
l1 = 2;
l2 = 2;
g = 9.8;
Ar = [0,1,0,0;-6,-5,0,0;0,0,0,1;0,0,-6,-5];
rho = 100;
rho2 = rho*rho;
%Q = [0.1,0,0,0;0,100,0,0;0,0,0.1,0;0,0,0,100];
Q = 0.1*eye(4);
%% create Fuzzy Rules
count = 1;
range = [-pi/3, pi/3];
for i = range
    for j = range
        for k = range
            for l = range
                eval(['A' num2str(count) '= fuzzy_A(i,j,k,l,m1,m2,l1,l2,g);'])
                eval(['B' num2str(count) '= fuzzy_B(i,j,k,l,m1,m2,l1,l2,g);'])
                eval(['C' num2str(count) ' = [1,0,0,0;0,0,1,0];'])
                count = count + 1;
            end
        end
    end
end
%% solve LMI for 4.99

% Before starting the description of a new LMI system with lmivar and lmiterm, type setlmis([]) to initialize its internal representation.
setlmis([]);
% check lmivar: https://www.mathworks.com/help/robust/ref/lmivar.html
W22 = lmivar(1,[4,1]);
for i = 1:16
    eval(['Y',num2str(i),'=lmivar(2,[2,4]);'])
end
% check limterm: https://www.mathworks.com/help/robust/ref/lmiterm.html
for i = 1:16
    eval(['lmiterm([' num2str(i) ',1,1,W22],A' num2str(i) ',1,"s");'])
    eval(['lmiterm([' num2str(i) ',1,1,Y' num2str(i) '],B' num2str(i) ',1,"s");'])
    eval(['lmiterm([' num2str(i) ',1,1,0],1/rho2);'])
    eval(['lmiterm([' num2str(i) ',2,1,W22],1,1);'])
    eval(['lmiterm([' num2str(i) ',2,2,0],-inv(Q))'])
end

lmiterm([-17,1,1,W22],1,1);
lmisys1 = getlmis;
[tmin1, xfeas1] = feasp(lmisys1);

if tmin1 >0
    dbstop;
end


W22 = dec2mat(lmisys1,xfeas1,W22);
P22 = inv(W22);
for i=1:16
    eval(['Y' num2str(i) '=dec2mat(lmisys1,xfeas1,Y' num2str(i) ');'])
    eval(['K' num2str(i) '= Y' num2str(i) '*P22;'])
end

%% create LMI for 4.96

setlmis([]);
P11 = lmivar(1,[4,1]);
P33 = lmivar(1,[4,1]);
for i = 1:16
    eval(['Z',num2str(i),'=lmivar(2,[4,2]);'])
end

for i=1:16
    % Diagonal terms
    eval(['lmiterm([' num2str(i) ',1,1,P11],1,A' num2str(i) ', "s");'])
    eval(['lmiterm([' num2str(i) ',1,1,Z' num2str(i) '],-1,C' num2str(i) ', "s");'])
    eval(['lmiterm([' num2str(i) ',2,2,0],-rho2);'])
    eval(['lmiterm([' num2str(i) ',3,3,0],-rho2);'])
    eval(['ABK = A' num2str(i) '+B' num2str(i) '*K' num2str(i) ';'])
    M44 = transpose(ABK)*P22 + P22*ABK + P22*P22/rho2 + Q;
    eval(['lmiterm([' num2str(i) ',4,4,0],M44);'])
    eval(['lmiterm([' num2str(i) ',5,5,P33],1,Ar,"s");'])
    eval(['lmiterm([' num2str(i) ',5,5,0],Q);'])
    eval(['lmiterm([' num2str(i) ',6,6,0],-rho2);'])
    % non-diagonal term
    eval(['lmiterm([' num2str(i) ',2,1,P11],1,1);'])
    eval(['lmiterm([' num2str(i) ',3,1,-Z' num2str(i) '],1,1);'])
    eval(['lmiterm([' num2str(i) ',4,1,P11],P22,1/rho2);'])
    eval(['M41 = -transpose(B' num2str(i) '*K' num2str(i) ')*P22;'])
    eval(['lmiterm([' num2str(i) ',4,1,0],M41);'])
    eval(['M54 = -P22*B' num2str(i) '*K' num2str(i) '-Q'])
    eval(['lmiterm([' num2str(i) ',5,4,0], transpose(M54));'])
    eval(['lmiterm([' num2str(i) ',6,5,P33],1,1);'])
    
end

lmiterm([-17,1,1,P11],1,1);
lmiterm([-18,1,1,P33],1,1);
lmisys2 = getlmis;
[tmin1, xfeas1] = feasp(lmisys2);

if tmin1 >0
    dbstop;
end

P11 = dec2mat(lmisys2,xfeas1,P11);
P33 = dec2mat(lmisys2,xfeas1,P33);

for i=1:16
    eval(['Z' num2str(i) '=dec2mat(lmisys2,xfeas1,Z' num2str(i) ');'])
    eval(['L' num2str(i) '= inv(P11)*Z' num2str(i) ';'])
end

%% create A_i_j and E_i
for i=1:16
    for j = 1:16
        eval(['a11 = A' num2str(i) '-L' num2str(i) '*C' num2str(j) ';'])
        a12 = zeros(4);
        a13 = zeros(4);
        eval(['a21 = -B' num2str(i) '*K' num2str(j) ';'])
        eval(['a22 = A' num2str(i) '+B' num2str(i) '*K' num2str(j) ';'])
        eval(['a23 = -B' num2str(i) '*K' num2str(j) ';'])
        a31 = zeros(4);
        a32 = zeros(4);
        a33 = Ar;
        eval(['A_' num2str(i) '_' num2str(j) '= [a11 a12 a13; a21 a22 a23; a31 a32 a33];'])
    end
    eval(['E_' num2str(i) '= [-L' num2str(i) ' eye(4), zeros(4); zeros(4,2) eye(4) zeros(4); zeros(4,2) zeros(4) eye(4)];'])
end


%% intialize
x0 = [0.5;0;-0.5;0];
xr = [0;0;0;0];
e = [0.5;0;-0.5;0];
%% Membership function
mf_p = fismf("trapmf", [-pi/3,pi/3,10000,10000]);
mf_n = fismf("trapmf", [-10000,-10000,-pi/3,pi/3]);

%% Generate state_trajectory

X_aug = zeros(12,3001);
X_aug(:,1) = [e;x0;xr];
count = 1;
for t = 0:0.01:30
    dx_aug = zeros(12,1);
    H_weighting = defuzzify(mf_p, mf_n, X_aug(4:8,count));
    for i = 1:16
        for j = 1:16
            % eval(['temp = A_' num2str(i) '_' num2str(j) '*X_aug(:,count)+E_' num2str(i) '*w;'])
            eval(['temp = Runge_Kutta_4th(X_aug(:,count),t,A_' num2str(i) '_' num2str(j) ',E_' num2str(i) ');'])
            dx_aug = dx_aug + H_weighting(i)*H_weighting(j)*temp;
        end
    end
    X_aug(:,count+1) = X_aug(:, count) + dx_aug;
    count = count + 1;
end
%% plot result
X = X_aug(5:8,:);
Xr = X_aug(9:12,:);
plot_state_trajectory(X, Xr)
























