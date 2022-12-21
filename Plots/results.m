clf
load Plots\sim_results_all.mat
colours = distinguishable_colors(10);
plotdefaults('AxisFontSize',16,'TextFontSize',16);
t = tiledlayout(2,2);
nexttile
xlabel('Time (minutes)')
ylabel('Temperature (C), Power (%kW), Liquid level (%)')
title('System and detector startup (2PACL)')
grid off
hold on
plot(sim_2pacl_concentric.setpoint.Time/60, sim_2pacl_concentric.setpoint.Data-273.15, "Color",colours(1,:))
plot(sim_2pacl_concentric.simlog.EH1a24.load.Q.series.time/60, sim_2pacl_concentric.simlog.EH1a24.load.Q.series.values*0.1, "Color",colours(2,:))

plot(sim_2pacl_concentric.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, sim_2pacl_concentric.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(3,:))
plot(sim_2pacl_concentric.simlog.AC4a54.Accu_control.Q.series.time/60, sim_2pacl_concentric.simlog.AC4a54.Accu_control.Q.series.values*0.1, "Color",colours(4,:))
plot(sim_2pacl_concentric.simlog.AC4a54.AC4a54.L.series.time/60, sim_2pacl_concentric.simlog.AC4a54.AC4a54.L.series.values*100, "Color",colours(5,:))
plot(sim_2pacl_concentric.simlog.Bypass_heater_pipe.H.T.series.time/60, sim_2pacl_concentric.simlog.Bypass_heater_pipe.H.T.series.values-273.15, "Color",colours(6,:))

plot(sim_2pacl_nonconcentric.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, sim_2pacl_nonconcentric.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(7,:))
plot(sim_2pacl_nonconcentric.simlog.AC4a54.Accu_control.Q.series.time/60, sim_2pacl_nonconcentric.simlog.AC4a54.Accu_control.Q.series.values*0.1, "Color",colours(8,:))
plot(sim_2pacl_nonconcentric.simlog.AC4a54.AC4a54.L.series.time/60, sim_2pacl_nonconcentric.simlog.AC4a54.AC4a54.L.series.values*100, "Color",colours(9,:))
plot(sim_2pacl_nonconcentric.simlog.Bypass_heater_pipe.H.T.series.time/60, sim_2pacl_nonconcentric.simlog.Bypass_heater_pipe.H.T.series.values-273.15, "Color",colours(10,:))

legend('Setpoint', 'Detector load', 'Concentric Tsat', 'Concentric control','Concentric level', 'Concentric evaporator temperature','Non-concentric Tsat', 'Non-concentric control','Non-concentric level', 'Non-concentric evaporator temperature', 'Location', 'southeast')

nexttile
hold on
title("Subcooling at the detector")
xlabel("Time (minutes)")
ylabel("Subcooling (C)")
xlim([0 165])
plot(sim_2pacl_concentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60,sim_2pacl_concentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-sim_2pacl_concentric.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(sim_2pacl_nonconcentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60,sim_2pacl_nonconcentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-sim_2pacl_nonconcentric.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(sim_i2pacl_concentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60,sim_i2pacl_concentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-sim_i2pacl_concentric.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(sim_i2pacl_nonconcentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60,sim_i2pacl_nonconcentric.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-sim_i2pacl_nonconcentric.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
legend("2PACL concentric", "2PACL non-concentric", "I2PACL concentric", "I2PACL non-concentric")

nexttile
xlabel('Time (minutes)')
ylabel('Temperature (C), Power (%kW), Liquid level (%)')
title('System and detector startup (I2PACL)')
grid off
hold on
plot(sim_i2pacl_concentric.setpoint.Time/60, sim_i2pacl_concentric.setpoint.Data-273.15, "Color",colours(1,:))
plot(sim_i2pacl_concentric.simlog.EH1a24.load.Q.series.time/60, sim_i2pacl_concentric.simlog.EH1a24.load.Q.series.values*0.1, "Color",colours(2,:))

plot(sim_i2pacl_concentric.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, sim_i2pacl_concentric.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(3,:))
plot(sim_i2pacl_concentric.simlog.AC4a54.Accu_control.Q.series.time/60, sim_i2pacl_concentric.simlog.AC4a54.Accu_control.Q.series.values*0.1, "Color",colours(4,:))
plot(sim_i2pacl_concentric.simlog.AC4a54.AC4a54.L.series.time/60, sim_i2pacl_concentric.simlog.AC4a54.AC4a54.L.series.values*100, "Color",colours(5,:))
plot(sim_i2pacl_concentric.simlog.Bypass_heater_pipe.H.T.series.time/60, sim_i2pacl_concentric.simlog.Bypass_heater_pipe.H.T.series.values-273.15, "Color",colours(6,:))

plot(sim_i2pacl_nonconcentric.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, sim_i2pacl_nonconcentric.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(7,:))
plot(sim_i2pacl_nonconcentric.simlog.AC4a54.Accu_control.Q.series.time/60, sim_i2pacl_nonconcentric.simlog.AC4a54.Accu_control.Q.series.values*0.1, "Color",colours(8,:))
plot(sim_i2pacl_nonconcentric.simlog.AC4a54.AC4a54.L.series.time/60, sim_i2pacl_nonconcentric.simlog.AC4a54.AC4a54.L.series.values*100, "Color",colours(9,:))
plot(sim_i2pacl_nonconcentric.simlog.Bypass_heater_pipe.H.T.series.time/60, sim_i2pacl_nonconcentric.simlog.Bypass_heater_pipe.H.T.series.values-273.15, "Color",colours(10,:))

legend('Setpoint', 'Detector load', 'Concentric Tsat', 'Concentric control','Concentric level', 'Concentric evaporator temperature','Non-concentric Tsat', 'Non-concentric control','Non-concentric level', 'Non-concentric evaporator temperature', 'Location', 'southeast')


%% TL length
close all
load TL_steps.mat
colours = distinguishable_colors(11);
plotdefaults('AxisFontSize',16,'TextFontSize',16);
figure
hold on
plot(out10.setpoint.Time/60, out10.setpoint.Data-273.15, "Color",colours(1,:))
plot(out10.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, out10.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(2,:))
plot(out20.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, out20.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(3,:))
plot(out30.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, out30.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(4,:))
plot(out40.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, out40.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(5,:))
plot(out50.simlog.AC4a54.ST4a54.T_sat_liq.series.time/60, out50.simlog.AC4a54.ST4a54.T_sat_liq.series.values-273.15, "Color",colours(6,:))
ylabel("Saturation temperature (C)")
yyaxis right
ylabel("Accumulator controller heat input (W)")
plot(out10.simlog.AC4a54.Accu_control.Q.series.time/60, out10.simlog.AC4a54.Accu_control.Q.series.values, '-', "Color",colours(7,:))
plot(out20.simlog.AC4a54.Accu_control.Q.series.time/60, out20.simlog.AC4a54.Accu_control.Q.series.values, '-',"Color",colours(8,:))
plot(out30.simlog.AC4a54.Accu_control.Q.series.time/60, out30.simlog.AC4a54.Accu_control.Q.series.values, '-',"Color",colours(9,:))
plot(out40.simlog.AC4a54.Accu_control.Q.series.time/60, out40.simlog.AC4a54.Accu_control.Q.series.values, '-',"Color",colours(10,:))
plot(out50.simlog.AC4a54.Accu_control.Q.series.time/60, out50.simlog.AC4a54.Accu_control.Q.series.values, '-',"Color",colours(11,:))
title("Set point tracking at different transfer line lengths")

xlabel("Time (minutes)")
legend('Setpoint', 'ST 10m', 'ST 20m', 'ST 30m', 'ST 40m', 'ST 50m', 'Control 10m', 'Control 20m', 'Control 30m', 'Control 40m', 'Control 50m')

figure
hold on
plot(out10.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60, out10.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-out10.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(out20.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60, out20.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-out20.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(out30.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60, out30.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-out30.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(out40.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60, out40.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-out40.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
plot(out50.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.time/60, out50.simlog.Saturation_Properties_Sensor_2P1.T_sat_liq.series.values-out50.simlog.Thermodynamic_Properties_Sensor_2P.T.series.values)
title("Subcooling at detector inlet with different transfer line lengths")
ylabel("Pre-evaporator sub-cooling (C)")
xlabel("Time (minutes)")
legend("10m", "20m", "30m", "40m","50m")

%% I2PACL steps
%load i2pacl_steps.mat
% close all
% figure
% hold on
% title("Performance limits in I2PACL mode")
% xlabel("Time (minutes)")
% yyaxis left
% ylabel("Saturation temperature (C)")
% plot(i2pacl_steps.setpoint.Time/60, i2pacl_steps.setpoint.Data-273.15)
% plot(i2pacl_steps.simlog.AC4a54.AC4a54.T_sat_liq.series.time/60, i2pacl_steps.simlog.AC4a54.AC4a54.T_sat_liq.series.values-273.15)
% yyaxis right
% ylabel('Accumulator control action (W)')
% plot(i2pacl_steps.simlog.AC4a54.Accu_control.Q.series.time/60, i2pacl_steps.simlog.AC4a54.Accu_control.Q.series.values)
% legend('Setpoint', 'Accumulator saturation temperature', 'Accumulator control action',"Location","southeast")