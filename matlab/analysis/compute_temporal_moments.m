function moments = compute_temporal_moments(t, c_out)
%COMPUTE_TEMPORAL_MOMENTS Compute outlet temporal moments.
%
% Inputs are physical time t and outlet concentration c_out.

M0 = trapz(t, c_out);
M1 = trapz(t, c_out .* t);
M2 = trapz(t, c_out .* t.^2);
M3 = trapz(t, c_out .* t.^3);

mu1 = M1 / M0;
mu2_raw = M2 / M0;
mu3_raw = M3 / M0;
mu2_central = mu2_raw - mu1^2;
mu3_central = mu3_raw - 3*mu1*mu2_raw + 2*mu1^3;

moments = struct();
moments.M0 = M0;
moments.M1 = M1;
moments.M2 = M2;
moments.M3 = M3;
moments.mu1 = mu1;
moments.mu2_raw = mu2_raw;
moments.mu3_raw = mu3_raw;
moments.mu2_central = mu2_central;
moments.mu3_central = mu3_central;
end
