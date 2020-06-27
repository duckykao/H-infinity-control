clear all
close all
clc
rng(randi(100000))
%% Initialzie all variables
% set both k1 and k3 having 1024 item so that the (B1,B3) = (10,10)
Routh_Hurwitz_pair = Routh_Hurwitz();
K1 = (1:1:1024);
K3 = (50:1:1074);

% random genreate 1000 point within 1024 which is the mapping of the k1 and k3
de_K = [randi([1,1023],1000,1) randi(1023,1000,1)];
init_pt = [randi([100,1023],1000,1) randi(512,1000,1)];

% check if the initialization works
check = 0;
while check == 0
    check = Initial_check(K1,K3,init_pt);
end
H2 = [];
% first parents
[fitness_result_by_order,H2_norm] = fitness_fn(K1,K3,init_pt);
H2 = [H2 H2_norm];
for i=1:50
    % copy from parent and do crossover
    copy_crossover = fitness_result_by_order(1:800,:);
    copy_crossover = Crossover(copy_crossover(:,1:10),copy_crossover(:,11:20));
    % copy from parent and do mutation
    copy_mutation = fitness_result_by_order(800+1:end,:);
    copy_mutation = Mutation(copy_mutation(:,1:10),copy_mutation(:,11:20));
    % combine parent and child
    parent_and_next_gen = [fitness_result_by_order;copy_crossover;copy_mutation];
    % check if them meet H infinity criteria
    survive = check_H_inf_criteria(K1, K3, parent_and_next_gen(:,1:10), parent_and_next_gen(:,11:20));
    % compute fitness and pick the top 1000 k1 k3 pairs
    [next_gen, H2_norm] = fitness_fn(K1,K3,de_K);
    fitness_result_by_order = next_gen;
    H2 = [H2 H2_norm];
end

plot((1:51),H2)
sort_de_K = sortrows(de_K);
best_sur = survive(1,:);
save data
%% defien functions
function [output, H2_norm] = fitness_fn(K1,K3,de_K)
    k1 = K1(de_K(:,1));
    k3 = K3(de_K(:,2));
    cost = (9*k3+12)./(-18*k1+36*k3);
    fitness = 1*ones(1,length(de_K))./cost;
    bi_k1k3 = d2b_k1k3(de_K(:,1), de_K(:,2));
    out_wo_sort = [bi_k1k3 fitness'];
    out_sorted = sortrows(out_wo_sort, size(out_wo_sort,2),'descend');
    output = out_sorted(:,1:20);
    H2_norm = vpa(1/out_sorted(1,21),10);
end

function output = d2b_k1k3(de_k1,de_k3)
    bi_k1 = de2bi(de_k1);
    bi_k3 = de2bi(de_k3);
    output = [bi_k1 bi_k3];
end









