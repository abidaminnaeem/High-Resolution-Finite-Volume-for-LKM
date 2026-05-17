function qstar = langmuir_isotherm(c, kh, b)
%LANGMUIR_ISOTHERM Nonlinear Langmuir equilibrium concentration.
%
% For a single component:
%   q* = kh*c/(1 + b*c)

qstar = (kh(:) .* c(:)) ./ (1.0 + b(:) .* c(:));
end
