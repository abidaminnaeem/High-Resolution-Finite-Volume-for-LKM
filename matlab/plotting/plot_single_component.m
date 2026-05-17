function plot_single_component(results)
%PLOT_SINGLE_COMPONENT Plot outlet concentration and gradient profile.

figure('Color', 'w');
[ax, h1, h2] = plotyy(results.t, results.c_outlet, results.t, results.phi_outlet);
set(h1, 'LineWidth', 2, 'LineStyle', '-');
set(h2, 'LineWidth', 2, 'LineStyle', '--');
set(get(ax(1), 'XLabel'), 'String', 't [min]');
set(get(ax(1), 'YLabel'), 'String', 'c(t,L) [mmol/L]');
set(get(ax(2), 'YLabel'), 'String', '\phi(t,L) [-]');
set(ax, 'FontSize', 12);
set(ax(2), 'YLim', [0 1]);
grid(ax(1), 'on');
title('Single-Component Gradient Elution LKM');
legend([h1; h2], {'Outlet concentration', 'Solvent gradient'}, 'Location', 'best');
end
