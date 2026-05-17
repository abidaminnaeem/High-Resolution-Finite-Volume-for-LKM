function results = run_gradient_elution_lkm()
%RUN_GRADIENT_ELUTION_LKM Main driver for nonlinear gradient elution LKM.
%
% This script/function initializes the single-column gradient elution
% chromatography problem, solves the semi-discrete finite-volume LKM system,
% computes temporal moments, and plots the outlet chromatogram.
%
% Usage:
%   results = run_gradient_elution_lkm();

clc; close all;

tic;

% Add modular folders to the MATLAB path.
thisFile = mfilename('fullpath');
[thisDir, ~, ~] = fileparts(thisFile);
addpath(genpath(thisDir));

% -------------------------------------------------------------------------
% Model and numerical parameters
% -------------------------------------------------------------------------
p = default_gradient_elution_parameters();

% Axial grid, dimensionless coordinate x in [0, 1].
p.L = linspace(0, p.Lmax, p.N).';
p.x = p.L / p.Lmax;
p.delx = p.x(2) - p.x(1);

% Initial conditions: liquid concentration c and solid concentration q.
c0 = zeros(p.N, 1);
q0 = zeros(p.N, 1);
x0 = [c0; q0];

% Dimensionless final time.
p.taumax = p.TIME * p.u / p.Lmax;
tau_grid = linspace(0, p.taumax, p.Nt);

fprintf('Simulation time: %.4f dimensionless units\n', p.taumax);
fprintf('Starting ODE45 solver for gradient elution LKM...\n');

ode_opts = odeset('RelTol', p.RelTol, 'AbsTol', p.AbsTol, 'Stats', 'off');
[tau, y] = ode45(@(tau, x) gradient_elution_lkm_solver(tau, x, p), tau_grid, x0, ode_opts);

fprintf('\nSimulation complete.\n');

% Outlet chromatogram and physical time.
cf = y(:, p.N);
t = tau * p.Lmax / p.u;
phi_out = outlet_gradient_profile(t, p);

% Temporal moments.
moments = compute_temporal_moments(t, cf);

disp('Temporal moments:');
disp(moments);

% Store results.
results = struct();
results.params = p;
results.tau = tau;
results.t = t;
results.y = y;
results.c_outlet = cf;
results.phi_outlet = phi_out;
results.moments = moments;
results.runtime_seconds = toc;

% Plot outlet chromatogram.
plot_single_component(results);

fprintf('Runtime: %.3f seconds\n', results.runtime_seconds);
end

function p = default_gradient_elution_parameters()
%DEFAULT_GRADIENT_ELUTION_PARAMETERS Parameter set matching the reference code.

p = struct();

% Physical/model parameters.
p.Lmax = 10.0;          % Column length
p.Dzr = 0.0002;         % Reference axial dispersion coefficient
p.cin = 1.0;            % Injected concentration
p.khr = 7.0;            % Reference Henry constant
p.Rp = 4.0e-3;          % Particle radius
p.Rcore = 0.0;          % Core radius
p.rhocore = p.Rcore / p.Rp;
p.b1ref = 2.0;          % Reference nonlinearity coefficient
p.u = 1.0;              % Interstitial velocity
p.Klkm = 10.0;          % Mass transfer coefficient
p.Kappalkm = p.Klkm * p.Lmax / p.u;
p.eps = 0.4;            % External porosity
p.F = (1.0 - p.eps) / p.eps;

% Injection and final time.
p.tinj = 10.0;
p.tauinj = p.tinj * p.u / p.Lmax;
p.TIME = 100.0;

% Gradient elution parameters.
p.ts = 5.0;
p.te = 40.0;
p.alpha1 = 0.90;
p.phi0 = 0.10;
p.phie = 0.95;
p.taus = p.ts * p.u / p.Lmax;
p.taue = p.te * p.u / p.Lmax;
p.beta1 = (p.phie - p.phi0) / (p.taue - p.taus);

% Numerics.
p.N = 301;
p.Nt = 300;
p.method = 'koren';     % Options: 'koren', 'bd', 'leveq'
p.RelTol = 1e-4;
p.AbsTol = 1e-4;
p.progress = true;
p.last_printed_tau = -inf;
end

function phi = outlet_gradient_profile(t, p)
%OUTLET_GRADIENT_PROFILE Solvent fraction profile in physical time units.
phi = zeros(size(t));
beta_physical = (p.phie - p.phi0) / (p.te - p.ts);
for i = 1:numel(t)
    if t(i) <= p.ts
        phi(i) = p.phi0;
    elseif t(i) > p.ts && t(i) <= p.te
        phi(i) = p.phi0 + beta_physical * (t(i) - p.ts);
    else
        phi(i) = p.phie;
    end
end
end
