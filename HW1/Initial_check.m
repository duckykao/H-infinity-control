%% Inintial Check 

function output = Initial_check(K1,K3,de_K) 
    len = length(de_K);
    output = 0;
    for i=1:len
        k1 = K1(de_K(i,1));
        k3 = K3(de_K(i,2));
        check = Infinity_Norm(k1,k3);
        if check == 0
            fprintf("Need to initial again in order to meet infinity criteria");
            return;
        end
    end
    output = 1;
    
end