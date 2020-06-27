function B = fuzzy_B(x1,x2,x3,x4,m1,m2,l1,l2,g)

s1 = sin(x1);
s2 = sin(x3);
c1 = cos(x1);
c2 = cos(x3);

s1s2_c1c2 = s1*s2+c1*c2;
common_de = m2*l1*l1*l2*l2*((m1+m2)-m2*s1s2_c1c2*s1s2_c1c2);

g11 = m2*l2*l2;
g12 = -m2*l1*l2*s1s2_c1c2;
g21 = g12;
g22 = (m1+m2)*l1*l1;


row1 = [0,0];
row2 = [g11, g12];
row3 = [0,0];
row4 = [g21, g22];

B = [row1;row2;row3;row4]/common_de;

end