%% check if meet H infinity criteria

function output = check_H_inf_criteria(K1,K3,parent_childern_k1, parent_childern_k3)
    de_K = b2d_k1k3(parent_childern_k1, parent_childern_k3);
    keep = [];
    for i = 1:length(de_K)
        k1 = K1(de_K(i,1));
        k3 = K3(de_K(i,2));
        satisfy = Infinity_Norm(k1,k3);
        if satisfy == 1
            keep = [keep; [k1 k3]];
        end
    end
    output = keep;
end