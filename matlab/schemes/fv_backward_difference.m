function rhs = fv_backward_difference(c, q, qstar, km, pe, BC, p)
%FV_BACKWARD_DIFFERENCE First-order backward finite-volume scheme.

N = p.N;
dx = p.delx;
rhs = zeros(2 * N, 1);

c_ext = [c; c(end)];
q_ext = [q; q(end)];
pe_ext = [pe; pe(end)];

rhs(1) = -(c_ext(1) - BC) / dx ...
    + (1 / pe_ext(1)) * (c_ext(2) - 2*c_ext(1) + BC) / dx^2 ...
    - (1 - p.rhocore^3) * p.F * km(1) * (qstar(1) - q_ext(1));
rhs(N+1) = km(1) * (qstar(1) - q_ext(1));

for j = 2:N
    rhs(j) = -(c_ext(j) - c_ext(j-1)) / dx ...
        + (1 / pe_ext(j)) * (c_ext(j+1) - 2*c_ext(j) + c_ext(j-1)) / dx^2 ...
        - (1 - p.rhocore^3) * p.F * km(j) * (qstar(j) - q_ext(j));
    rhs(j+N) = km(j) * (qstar(j) - q_ext(j));
end
end
