function A = fuzzy_A(r,V_theta,V_phi,phi)

A = [0 0 0 1 0 0;
    0 0 0 0 1/(r*cos(phi)) 0;
    0 0 0 0 0 1/r;
    0 0 0 0 V_theta/r V_phi/r;
    0 0 0 -V_theta/r 0 V_theta*tan(phi)/r;
    0 0 0 -V_phi/r -V_theta*tan(phi)/r 0];

end