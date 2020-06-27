%% check infinity norm criteria
% run points from 0 to 1000 representing the frequency
% apply equation 3.21 by not expanding the transfer function
% but just simply replace jw to the s part

function output = Infinity_Norm(k1,k3)
    w = (0:1000);
    P_jw = (1.5*ones(1,1001))./((1i*w).*(1i*w));
    P_njw = (1.5*ones(1,1001))./((-1i*w).*(-1i*w));
    
    C_jw = k1+1i*k3*w;
    C_njw = k1-1i*k3*w;
    
    L_jw = (0.5*ones(1,1001))./((1i*w).*(1i*w)+0.1*(1i*w)+10);
    L_njw = (0.5*ones(1,1001))./((-1i*w).*(-1i*w)+0.1*(-1i*w)+10);
   
    num = P_jw.*P_njw.*C_jw.*C_njw.*L_jw.*L_njw;
    dom = (1+P_njw.*C_njw).*(1+P_jw.*C_jw);
    max_r = max(real(sqrt(num./dom)));
    if max_r <= 1
        output = 1;
    else
        output = 0;
    end
    
end