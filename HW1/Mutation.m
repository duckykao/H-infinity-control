%% Mutation function
% In mutation we take 20% of data and split it to half
% 10% of it we mutate the k1 part  ==> [mutated_k1  original_k3]
% 10% of it we mutate the k3 part  ==> [original_k1 mutated_k3]
% then we combine them together as ouput

function output = Mutation(bi_k1, bi_k3)
    selected_length = length(bi_k1);
    mutation_term = randi(10,1,selected_length);
    for i = 1:selected_length/2
        m = bi_k1(i,mutation_term(i));
        if m == 1
            m = 0;
        else
            m = 1;
        end
        bi_k1(i,mutation_term(i)) = m;
        % this is to prevent from mapping to 0 making errrors like
        % Array indices must be positive integers or logical values. 
        % during the K3(de_K(i,2)) part
        if bi2de(bi_k1(i)) == 0
            bi_k1(i,mutation_term(1)) = 1;
        end
    end
    
    for i = selected_length/2+1:selected_length
        m = bi_k3(i,mutation_term(i));
        if m == 1
            m = 0;
        else
            m = 1;
        end
        bi_k3(i,mutation_term(i)) = m;
        % this is to prevent from mapping to 0 making errrors like
        % Array indices must be positive integers or logical values. 
        % during the K3(de_K(i,2)) part
        if bi2de(bi_k3(i)) == 0
            bi_k3(i,mutation_term(10)) = 1;
        end
    end
    output = [bi_k1 bi_k3];
end