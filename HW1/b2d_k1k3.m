%% binary to decimal function
% input binary encoding of k1 and binary encoding of k3
% output decimal of [k1, k3]

function  output = b2d_k1k3(bi_k1, bi_k3)
    de_k1 = bi2de(bi_k1);
    de_k3 = bi2de(bi_k3);
    output = [de_k1 de_k3];
end