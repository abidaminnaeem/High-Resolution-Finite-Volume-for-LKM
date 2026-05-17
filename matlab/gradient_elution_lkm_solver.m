function dy = gradient_elution_lkm_solver(tau, x, p)
%GRADIENT_ELUTION_LKM_SOLVER RHS for nonlinear gradient elution LKM.
%
% The state x = [c; q], where c is liquid-phase concentration and q is
% solid-phase concentration on the axial grid. Spatial derivatives are
% approximated using finite-volume schemes.

N = p.N;

dy = zeros(2 * N, 1);

% Rectangular injection boundary condition.
if tau <= p.tauinj
    BC = p.cin;
else
    BC = 0.0;
end

c = x(1:N);
q = x(N+1:2*N);

% Solvent-strength-dependent model parameters.
[km, kh, D, b1] = lss_parameter_model(tau, p);
qstar = langmuir_isotherm(c, kh, b1);
pe = (p.Lmax * p.u) ./ D;

switch lower(p.method)
    case 'bd'
        dy(:) = fv_backward_difference(c, q, qstar, km, pe, BC, p);
    case 'koren'
        dy(:) = fv_koren_tvd(c, q, qstar, km, pe, BC, p);
    case 'leveq'
        dy(:) = fv_leveque_tvd(c, q, qstar, km, pe, BC, p);
    otherwise
        error('Unknown finite-volume method: %s', p.method);
end

if isfield(p, 'progress') && p.progress
    persistent lastPrinted
    if isempty(lastPrinted)
        lastPrinted = -inf;
    end
    if floor(tau) > floor(lastPrinted)
        fprintf('Current dimensionless time: %d\r', floor(tau));
        lastPrinted = tau;
    end
end
end
