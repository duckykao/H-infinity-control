function output = defuzzy(x)

mem_r1 = fismf("trapmf", [-1000000,-1000000,1000,9000]);
mem_r2 = fismf("trapmf", [1000,9000,1000000,1000000]);
mem_theta1 = fismf("trapmf", [-1000000,-1000000,-200,0]);
mem_theta2 = fismf("trimf", [-200 0 200]);
mem_theta3 = fismf("trapmf", [0,200,1000000,1000000]);
mem_phi1 = fismf("trapmf", [-1000000,-1000000,-200,0]);
mem_phi2 = fismf("trimf", [-200 0 200]);
mem_phi3 = fismf("trapmf", [0,200,1000000,1000000]);
mem_p1 = fismf("trapmf", [-1000000,-1000000,-pi/3,pi/3]);
mem_p2 = fismf("trapmf", [-pi/3,pi/3,1000000,1000000]);

H = zeros(1,36);
count = 1;
for i = 1:2
    for j = 1:3
        for k = 1:3
            for l = 1:2
                eval(['H(' num2str(count) ') = evalmf(mem_r' num2str(i) ', x(1))* evalmf(mem_theta' num2str(j) ',x(5))* evalmf(mem_phi' num2str(k) ',x(6))* evalmf(mem_p' num2str(l) ',x(3));']);
                count = count + 1;
            end
        end
    end
end

output = H/sum(H);
end

