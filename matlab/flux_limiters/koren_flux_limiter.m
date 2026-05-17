function phi = koren_flux_limiter(r)
%KOREN_FLUX_LIMITER Koren TVD flux limiter.
%
%   phi(r) = max(0, min(2r, min(1/3 + 2r/3, 2)))

phi = max(0.0, min(2.0 .* r, min(1.0/3.0 + (2.0/3.0) .* r, 2.0)));
end
