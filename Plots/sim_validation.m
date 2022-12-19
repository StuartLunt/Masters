load("digitise.mat")
load verification.mat

%%
close all
figure
plotdefaults('AxisFontSize',16,'TextFontSize',16);
colours = distinguishable_colors(8);
hold on
plot(detector.x/60, detector.AccuLevel,"-", "DisplayName", "Real level", "Color",colours(1,:))
plot(detector.x/60, detector.DetectorLoad+detector.ModuleLoad, "--", "DisplayName", "Real detector load", "Color",colours(1,:))
plot(detector.x/60, detector.AccuControl, ":", "DisplayName", "Real accumulator control", "Color",colours(1,:))
plot(detector.x/60, detector.AccuTsat, "-.", "DisplayName", "Real accumulator satruation", "Color",colours(1,:))

start_time = 1115+50.3*60

start = findPosition(start_time,sim.simlog.AC4a54.AC4a54.L.series.time);
data = sim.simlog.AC4a54.AC4a54.L.series.values*100;
time = sim.simlog.AC4a54.AC4a54.L.series.time;
plot((time(start:end)-start_time)/60, data(start:end), "-", "DisplayName","Sim level", "Color",colours(2,:))

start = findPosition(start_time,sim.simlog.EH1a24.load.Q.series.time)
data = sim.simlog.EH1a24.load.Q.series.values/10;
time = sim.simlog.EH1a24.load.Q.series.time;
plot((time(start:end)-start_time)/60, data(start:end), "--", "DisplayName","Sim detector load", "Color",colours(2,:))

start = findPosition(start_time,sim.simlog.AC4a54.Accu_control.Q.series.time)
data = sim.simlog.AC4a54.Accu_control.Q.series.values/10;
time = sim.simlog.AC4a54.Accu_control.Q.series.time;
plot((time(start:end)-start_time)/60, data(start:end), ":", "DisplayName","Sim accumulator control", "Color",colours(2,:))

start = findPosition(start_time,sim.simlog.AC4a54.AC4a54.T_sat_liq.series.time)
data = sim.simlog.AC4a54.AC4a54.T_sat_liq.series.values-273.15;
time = sim.simlog.AC4a54.AC4a54.T_sat_liq.series.time;
plot((time(start:end)-start_time)/60, data(start:end), "-.", "DisplayName","Sim accumulator saturation", "Color",colours(2,:))

title("Comparison of real detector start up to a simulated detector start up")
ylabel("Level (%), Power (% of 1kW), Saturation temperature (C)")
xlabel("Time (minutes)")
xlim([0 120])

legend