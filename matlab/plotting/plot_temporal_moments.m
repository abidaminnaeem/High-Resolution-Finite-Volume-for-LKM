function plot_temporal_moments(moment_values, parameter_values, parameter_name)
%PLOT_TEMPORAL_MOMENTS Plot moment trends versus a varied parameter.

figure('Color', 'w');
plot(parameter_values, moment_values, 'o-', 'LineWidth', 2);
xlabel(parameter_name, 'Interpreter', 'none');
ylabel('Temporal moment');
title('Temporal Moment Trend');
grid on;
end
