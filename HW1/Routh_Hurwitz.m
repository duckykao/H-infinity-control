%% Routh Hurwitz function

% run through all the possible k1 and k3 
% and find the possible pairs 

function output = Routh_Hurwitz()
    Routh_Hurwitz_pair = [];
    for k1=1:100
        for k3=1:100
            r = real(roots([1,2,3*k3,3*k1]));
            if r<=0
                Routh_Hurwitz_pair = [Routh_Hurwitz_pair;[k1 k3]];
            end
        end
    end
    output = Routh_Hurwitz_pair;
end