function [km, kh, D, b1] = lss_parameter_model(tau, p)
%LSS_PARAMETER_MODEL Linear Solvent Strength parameter model.
%
% Parameters are evaluated along the column using xi = tau - x, where x is
% the dimensionless axial coordinate. The model follows exponential
% solvent-strength dependence.

N = p.N;
km = zeros(N, 1);
kh = zeros(N, 1);
D  = zeros(N, 1);
b1 = zeros(N, 1);

for i = 1:N
    xi = tau - p.x(i);

    if xi < p.taus
        phi = p.phi0;
    elseif xi >= p.taus && xi <= p.taue
        phi = p.phi0 + p.beta1 * (xi - p.taus);
    else
        phi = p.phie;
    end

    factor = exp(-p.alpha1 * phi);
    km(i) = p.Kappalkm * factor;
    kh(i) = p.khr * factor;
    D(i)  = p.Dzr * factor;
    b1(i) = p.b1ref * factor;
end
end
