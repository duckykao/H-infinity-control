function A = fuzzy_A(x1,x2,x3,x4,m1,m2,l1,l2,g)

s1 = sin(x1);
s2 = sin(x3);
c1 = cos(x1);
c2 = cos(x3);

s1s2_c1c2 = s1*s2+c1*c2;
f1_de = l1*l2*((m1+m2)-m2*s1s2_c1c2*s1s2_c1c2);
f2_de = (m1+m2)*l2*g*s1-m2*l2*g*s2*s1s2_c1c2;
com_f1_f2 = (s1*c2-c1*s2);


row1 = [0,1,0,0];
row2 = [(m1+m2)*l2*g*s1/x1, com_f1_f2*m2*l1*l2*s1s2_c1c2*x2, -m2*l2*g*s2*s1s2_c1c2/x3, -com_f1_f2*m2*l2*l2*x4]/f1_de;
row3 = [0,0,0,1];
row4 = [-(m1+m2)*l1*g*s1*s1s2_c1c2/x1, -com_f1_f2*(m1+m2)*l1*l1*x2, +(m1+m2)*l1*g*s2/x3, com_f1_f2*m2*l1*l2*s1s2_c1c2*x4]/f2_de;
A = [row1;row2;row3;row4];


end