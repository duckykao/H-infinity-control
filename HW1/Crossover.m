%% Crossover
% In crossover we take 80% of data to do random perturbation
% taking good chromoson and exchange the good pairs
% seeing that if it can reach the optimality

function output = Crossover (bi_k1, bi_k3)
    or1 = bi_k1;
    or3 = bi_k3;
    selected_length = length(bi_k1);
    perturbation_1 = bi_k1(randperm(selected_length)',:);
    perturbation_2 = bi_k3(randperm(selected_length)',:);
    output = [perturbation_1 perturbation_2];
end