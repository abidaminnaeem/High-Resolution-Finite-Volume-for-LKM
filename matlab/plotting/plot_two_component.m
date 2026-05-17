function plot_two_component(results)
%PLOT_TWO_COMPONENT Placeholder for two-component result plotting.
%
% Extend this function once the two-component driver is added.

figure('Color', 'w');
plot(results.t, results.c_outlet, 'LineWidth', 2);
xlabel('t [min]');
ylabel('c_i(t,L) [mmol/L]');
title('Two-Component Gradient Elution LKM');
grid on;
end
