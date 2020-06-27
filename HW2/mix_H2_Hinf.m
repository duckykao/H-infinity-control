%% Perform minimizing rho and gamma for mix H2/H inf control
% input : initial value, rho and gamma A,B,C1,C2,D,Q1,Q2,R
% output : P2,L,P1,K,min_rho,min_gamma
function [P2,L,P1,K,rho,gamma] = mix_H2_Hinf(init_val,r,g,A,B,C1,C2,D,Q1,Q2,R)
%% Initial paramtes

% H2 parameters
sqr_R0 = real(sqrtm(init_val*init_val'));
rho = r; %40.5169;
gamma = g; %50;
counter = 0;

%% solve LMI to get all wanted variables

while counter < 1000
    % solve LMI to get P2 and L
    
    % Before starting the description of a new LMI system with lmivar and lmiterm, type setlmis([]) to initialize its internal representation.
    setlmis([]); 
    % check lmivar: https://www.mathworks.com/help/robust/ref/lmivar.html
    p2 = lmivar(1,[2,1]);
    w2 = lmivar(2,[2,1]); % W2 does not required to be symmetric
    % check limterm: https://www.mathworks.com/help/robust/ref/lmiterm.html
    lmiterm([1,1,1,0],Q2);
    lmiterm([1,1,1,p2],1,A,'s');
    lmiterm([1,1,1,w2],-1,D,'s');
    lmiterm([1,2,1,p2],1,1);
    lmiterm([1,3,1,-w2],1,1);
    lmiterm([1,2,2,0],-rho*rho);
    lmiterm([1,3,3,0],-rho*rho);
    
    lmiterm([-2,1,1,p2],1,1); % P2>0

    lmisys1 = getlmis;
    [tmin1, xfeas1] = feasp(lmisys1);
    if tmin1 > 0
        disp("tmin1 break out");
    end

    % solve LMI to get P1 and K
    
    setlmis([]);
    w1 = lmivar(1,[2,1]); % w1 = P1^-1
    y = lmivar(2,[1,2]);

    rho_2 = 1/(rho*rho)*eye(2);

    lmiterm([1,1,1,w1],A,1,'s');
    lmiterm([1,1,1,y],B,1,'s');
    lmiterm([1,1,1,0],rho_2);
    lmiterm([1,2,1,w1],1,1);
    lmiterm([1,3,1,w1],C1,1);
    lmiterm([1,4,1,w1],C2,1);
    lmiterm([1,2,2,0],-inv(Q1));
    lmiterm([1,3,3,w1],-1,1);
    lmiterm([1,4,4,w1],-1,1);
    %lmiterm([1,5,1,y],1,1);
    %lmiterm([1,5,5,0],-inv(R));

    lmiterm([-2,1,1,inv(w1)],1,1); % P>0

    % LMI for H2 performance
    lmiterm([3,1,1,w1],A,1,'s');
    lmiterm([3,1,1,y],B,1,'s');
    lmiterm([3,2,1,w1],1,1);
    lmiterm([3,3,1,w1],C1,1);
    lmiterm([3,4,1,w1],C2,1);
    lmiterm([3,5,1,y'],1,1);
    lmiterm([3,2,2,0],-inv(Q1));
    lmiterm([3,3,3,w1],-1,1);
    lmiterm([3,4,4,w1],-1,1);
    lmiterm([3,5,5,0],-inv(R));

    lmiterm([-4,1,1,0],gamma/2);
    lmiterm([-4,2,2,w1],1,1);
    lmiterm([-4,2,1,0],sqr_R0);

    lmisys2 = getlmis;

    [tmin2, xfeas2] = feasp(lmisys2);
    if tmin2>0
        disp("tmin2 Break out");
        break;
    end
    
    P2 = dec2mat(lmisys1,xfeas1,p2);
    W2 = dec2mat(lmisys1,xfeas1,w2);
    L = inv(P2)*W2;
    
    W1 = dec2mat(lmisys2,xfeas2,w1);
    Y = dec2mat(lmisys2,xfeas2,y);
    P1 = inv(W1);
    K = Y*P1;
    counter = counter + 1;
    rho = rho - rho/1000;
    gamma = gamma - gamma/1000;
end 
disp(counter);
disp(tmin2);
end