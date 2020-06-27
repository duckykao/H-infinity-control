function output = defuzzify(mem1, mem2, x)

h1 = evalmf(mem1,x(1))*evalmf(mem1,x(2))*evalmf(mem1,x(3))*evalmf(mem1,x(4));
h2 = evalmf(mem1,x(1))*evalmf(mem1,x(2))*evalmf(mem1,x(3))*evalmf(mem2,x(4));
h3 = evalmf(mem1,x(1))*evalmf(mem1,x(2))*evalmf(mem2,x(3))*evalmf(mem1,x(4));
h4 = evalmf(mem1,x(1))*evalmf(mem1,x(2))*evalmf(mem2,x(3))*evalmf(mem2,x(4));
h5 = evalmf(mem1,x(1))*evalmf(mem2,x(2))*evalmf(mem1,x(3))*evalmf(mem1,x(4));
h6 = evalmf(mem1,x(1))*evalmf(mem2,x(2))*evalmf(mem1,x(3))*evalmf(mem2,x(4));
h7 = evalmf(mem1,x(1))*evalmf(mem2,x(2))*evalmf(mem2,x(3))*evalmf(mem1,x(4));
h8 = evalmf(mem1,x(1))*evalmf(mem2,x(2))*evalmf(mem2,x(3))*evalmf(mem2,x(4));
h9 = evalmf(mem2,x(1))*evalmf(mem1,x(2))*evalmf(mem1,x(3))*evalmf(mem1,x(4));
h10 = evalmf(mem2,x(1))*evalmf(mem1,x(2))*evalmf(mem1,x(3))*evalmf(mem2,x(4));
h11 = evalmf(mem2,x(1))*evalmf(mem1,x(2))*evalmf(mem2,x(3))*evalmf(mem1,x(4));
h12 = evalmf(mem2,x(1))*evalmf(mem1,x(2))*evalmf(mem2,x(3))*evalmf(mem2,x(4));
h13 = evalmf(mem2,x(1))*evalmf(mem2,x(2))*evalmf(mem1,x(3))*evalmf(mem1,x(4));
h14 = evalmf(mem2,x(1))*evalmf(mem2,x(2))*evalmf(mem1,x(3))*evalmf(mem2,x(4));
h15 = evalmf(mem2,x(1))*evalmf(mem2,x(2))*evalmf(mem2,x(3))*evalmf(mem1,x(4));
h16 = evalmf(mem2,x(1))*evalmf(mem2,x(2))*evalmf(mem2,x(3))*evalmf(mem2,x(4));

H = [h1	h2	h3	h4	h5	h6	h7	h8	h9	h10	h11	h12	h13	h14	h15	h16];
output = H/sum(H);
end