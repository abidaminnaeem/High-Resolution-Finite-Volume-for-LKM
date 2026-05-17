function rhs = fv_leveque_tvd(c, q, qstar, km, pe, BC, p)
%FV_LEVEQUE_TVD LeVeque-style TVD placeholder using van Leer limiter.
%
% The original reference code used a LIMWAV helper that was not included in
% the uploaded files. This implementation provides a self-contained van Leer
% limiter variant so the module remains executable.

N = p.N;
dx = p.delx;
rhs = zeros(2 * N, 1);

c_ext = [c; c(end)];
q_ext = [q; q(end)];
pe_ext = [pe; pe(end)];

phi = ones(N+1, 1);
small = 1e-10;
for i = 2:N
    r = (c_ext(i) - c_ext(i-1) + small) / (c_ext(max(i-1,1)) - c_ext(max(i-2,1)) + small);
    phi(i) = (r + abs(r)) / (1 + abs(r)); % van Leer limiter
end

rhs(1) = -(c_ext(1) - BC) / dx ...
    + (1 / pe_ext(1)) * (c_ext(2) - 2*c_ext(1) + BC) / dx^2 ...
    - (1 - p.rhocore^3) * p.F * km(1) * (qstar(1) - q_ext(1));
rhs(N+1) = km(1) * (qstar(1) - q_ext(1));

for i = 2:N
    high_res_flux = (phi(i+1) * (c_ext(i+1) - c_ext(i)) ...
        - phi(i) * (c_ext(i) - c_ext(i-1))) / (2.0 * dx);

    rhs(i) = -(c_ext(i) - c_ext(i-1)) / dx ...
        - high_res_flux ...
        + (1 / pe_ext(i)) * (c_ext(i+1) - 2*c_ext(i) + c_ext(i-1)) / dx^2 ...
        - (1 - p.rhocore^3) * p.F * km(i) * (qstar(i) - q_ext(i));
    rhs(i+N) = km(i) * (qstar(i) - q_ext(i));
end
end
