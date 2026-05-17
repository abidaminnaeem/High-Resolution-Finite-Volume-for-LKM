function rhs = fv_koren_tvd(c, q, qstar, km, pe, BC, p)
%FV_KOREN_TVD High-resolution finite-volume scheme with Koren limiter.

N = p.N;
dx = p.delx;
rhs = zeros(2 * N, 1);

c_ext = [c; c(end)];
q_ext = [q; q(end)];
pe_ext = [pe; pe(end)];

phi = ones(N, 1);
small = 1e-10;
for i = 2:N-1
    r = (c_ext(i+1) - c_ext(i) + small) / (c_ext(i) - c_ext(i-1) + small);
    phi(i) = koren_flux_limiter(r);
end
phi(N) = 1.0;

rhs(1) = -(c_ext(1) - BC) / dx ...
    + (1 / pe_ext(1)) * (c_ext(2) - 2*c_ext(1) + BC) / dx^2 ...
    - (1 - p.rhocore^3) * p.F * km(1) * (qstar(1) - q_ext(1));
rhs(N+1) = km(1) * (qstar(1) - q_ext(1));

rhs(2) = -(c_ext(2) - c_ext(1)) / dx ...
    + (1 / pe_ext(2)) * (c_ext(3) - 2*c_ext(2) + c_ext(1)) / dx^2 ...
    - (1 - p.rhocore^3) * p.F * km(2) * (qstar(2) - q_ext(2));
rhs(N+2) = km(2) * (qstar(2) - q_ext(2));

for i = 3:N
    high_res_flux = (phi(i) * (c_ext(i) - c_ext(i-1)) ...
        - phi(i-1) * (c_ext(i-1) - c_ext(i-2))) / (2.0 * dx);

    rhs(i) = -(c_ext(i) - c_ext(i-1)) / dx ...
        - high_res_flux ...
        + (1 / pe_ext(i)) * (c_ext(i+1) - 2*c_ext(i) + c_ext(i-1)) / dx^2 ...
        - (1 - p.rhocore^3) * p.F * km(i) * (qstar(i) - q_ext(i));
    rhs(i+N) = km(i) * (qstar(i) - q_ext(i));
end
end
