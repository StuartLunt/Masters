% c = refpropm('C', 'T', 248, 'P', 2, 'CO2');
% 
% mdot = linspace(4, 22);
% 
% dtmax = 1000./(c.*(mdot/1000));
% dt750 = 750./(c.*(mdot/1000));
% dt500 = 500./(c.*(mdot/1000));
% 
% spmax = dtmax-40;
% sp750 = dt750-40;
% sp500 = dt500-40;
% 
% figure
% title('Theoretical maximum set point')
% ylabel('CO2 temperature (C)')
% xlabel('Flow (g/s)')
% hold on
% grid on
% plot(mdot,spmax)
% plot(mdot,sp750)
% plot(mdot,sp500)
% legend('1000W', '750W', '500W')

%% Fixed calcs
setpoint = linspace(233,293,200);
for i = 1:length(setpoint)
    pres(i) = refpropm('P', 'T', setpoint(i), 'Q',0,'CO2');
    c(i)=refpropm('C', 'T', 248, 'P', pres(i)+500, 'CO2');
end
ct = 233;
m_dot = [0.006 0.008 0.01 0.012 0.014];
for a = 1:5
    p(a,:) = c.*m_dot(a).*(setpoint-ct);
end
figure
plot(setpoint-273,p)
yline(1000,'--r', 'Maximum heater power')
title('Power required to maintain the set point at different flow rates (g/s)')
ylabel('Heater power (W)')
xlabel('Set point (C)')
legend('6 g/s', '8 g/s', '10 g/s', '12 g/s','14 g/s')