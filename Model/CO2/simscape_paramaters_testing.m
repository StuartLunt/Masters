% Constants for Simscape
load('CO2properties.mat');
load('R449.mat');
load('co2tables.mat');

pump_volume = 9.5e-6;
% sp=4;

%% Initial conditions
initPressure = 5.7; %mpa
initTemp = 20+273.15; %K
T_ambient = 273.15+20; %K
voidFrac = 0.5;

initPresR449 = 0.4; %MPa

sh_sp = 4; %Superheating set point for chiller expansion valves

ptDelay = 0.25;
ttDelay = 0.5;

heater_vol = 0.04523893; %litres
t_cool = 1500+500;
t_start = 3000+t_cool;
sp_change = t_start + 1800 + 400;
det_off = sp_change+ 3000;

det_power = 600;

%% System parameters
% Quater inch pipe
quater_diameter = 6.35/1000;
quater_area = pi*(quater_diameter/2)^2;
quater_wall_thickness = 0.89/1000; %Measure to confirm

% 3/8 inch pipe
three_eight_diameter = 9.53/1000;
three_eight_area = pi*(three_eight_diameter/2)^2;
three_eight_wall_thickness = 0.89/1000;

% Accumulator properties
A_vol =14; %litre
A_mass = 30;
A_diameter = 168.28/1000;

SS_conductivity = 16; %esa reference
SS_density = 8000; %kg/m3 thuyssen-krupp
SS_specific_heat = 450;

%Heat exchanger paramaters
hx_length = 11; %m
hx_mass = three_eight_wall_thickness*hx_length*pi*three_eight_diameter*SS_density;
hx_sa = pi*three_eight_diameter*hx_length;

%System volume
sys_vol = 0.005;

% Insulation
I_thickness = 0.032;
I_conductivity = 0.033; %w/(m.k)
I_area = 0.5;



%% Accumulator
Acc_volume = 14.203; %litres
Acc_pipe_diameter = 6.35;
Acc_pipe_area = pi*(Acc_pipe_diameter/2)^2;
Acc_thickness = 0.00711;

Acc_init_pressure = 60; %bar
Acc_init_temp = 20; %c
Acc_phase_time_constant = 0.1; %Default

%% Damper
damper_volume = 500; %cc
damper_port_diamater = 6.35;
damper_port_area = pi*(damper_port_diamater/2)^2;

%% Transfer line
TL_length = 10;
TL_supply_diameter = 0.005;
TL_supply_cross_section = pi*(TL_supply_diameter/2)^2;

TL_return_innerdiameter = 0.006;
TL_return_outerdiameter = 0.014;

TL_return_cross_section = pi*(TL_return_outerdiameter/2)^2-pi*(TL_return_innerdiameter/2)^2;
TL_return_diameter = 2*(sqrt(TL_return_cross_section/pi));

TL_wall_thickness = 0.001;

TL_init_pressure = 0;
TL_init_temp = 0;
TL_phase_time_constant = 0;

%% Condenser
C_area = 164000; %mm^2
plate_area= C_area/12;
plate_thickness = 1.96; %mm
C_nop = 12;
plate_mass = 0.22;
ss316_sp = 500; %J/kgK
ss316_tc = 16.3; %W/mK
pipe_length = 1.366;


%% Expansion valve
min_throat_area = 0.000001;
max_throat_area = 1.5;


%% Evaparator
E_coolant_temp = 0;
E_material_mass = 0;
E_material_specific_heat = 0;
E_area = 0;

%% SWEP heat exchanger
swep_plates = 12;
swep_mass = 1.55+0.22*swep_plates;
swep_area = 164000; %mm2
swep_thickness = 0.002; %m

swep_radius = 3.8; %mm
swep_cross_section = pi*swep_radius^2; %mm2
swep_length = swep_area/(2*pi*swep_radius);

%% Pump
input_diamater = quater_area;
output_diamater = quater_area;
flow_rate = 12.5e-6; %m3/s
%% CO2 two phase

%% Chiller paramaters
compDisp = 32.5/(36002); %m^3/s @ 1450 rpm
compDiaSuction = 28;
suctionArea=pi*(compDiaSuction/2000)^2; %m^2
compDiaDischarge = 22;
dischargeArea=pi*(compDiaDischarge/2000)^2; %m^2

%% Chiller condensor paramaters
coil_volume = 0.0223; %m3
copper_density = 8940;
copper_conductivity = 400;
copper_specific_heat = 390;
evaporator_length = 30;
pipe_diameter = 0.01;
pipe_thickness = 0.001;
condenser_length = coil_volume/(pi*(pipe_diameter/2)^2);
fin_area = 1;
fin_convection_coefficient = 150;

%% Controllers
SHC5018sp = 10;
STC5018sp = -40;
TC5018sp = -35;


% co2tables = twoPhaseFluidTables([100,1000],[1,7],500,500,1500,'co2','C:\Program Files (x86)\REFPROP')