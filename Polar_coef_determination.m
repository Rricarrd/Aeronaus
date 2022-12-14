clear
clc

%% Data
e_oswald=0.85;
AR=9;
T_max=16540;

V_max = (800/3.6)/0.8;
MTOW = 4959;
W=MTOW*9.81;
rho_0=1.225;
S_wing=21.34;
rho=0.3636;
sigma=rho/rho_0;
loading = W/S_wing;
k_uc_landing = 4.5e-5;
k_uc_takeoff = 3.16e-5;
Mcr = 0.65;

%Cd0
K=1/(pi*e_oswald*AR);
CD0=(2*T_max-(4*K*W^2)/(rho*sigma*V_max^2*S_wing))/(rho_0*V_max^2*S_wing);

%Vecotrs de Cl i Cd
CL=-1:0.01:3;
CL_min_drag = 0.26;
CD=CD0+K*(CL-CL_min_drag).^2;



%deltaCd tren 
deltaCd_gear_landing = loading*k_uc_landing*MTOW^(-0.215);
deltaCd_gear_takeoff = loading*k_uc_takeoff*MTOW^(-0.215);

%deltaCd flaps

deltaCd_flaps_landing = 0.12;
deltaCd_flaps_takeoff = 0.04; 


%% Plots
%ClCd cruise prandtl galuert correction
figure
CD_cruise = CD/sqrt(1-Mcr^2);
plot(CD_cruise,CL)

hold on
%ClCd takeoff
CD_takeoff = CD + deltaCd_gear_takeoff + deltaCd_flaps_takeoff;
plot(CD_takeoff,CL)

%ClCd landing
CD_landing = CD + deltaCd_gear_landing + deltaCd_flaps_landing;
plot(CD_landing,CL)

%ClCd takeoff no gear
CD_takeoff_no_gear = CD + deltaCd_flaps_takeoff;
plot(CD_takeoff_no_gear,CL)

%ClCd landing no gear
CD_landing_no_gear = CD + deltaCd_flaps_landing;
plot(CD_landing_no_gear,CL)


%Parametres
xlabel('CD');
ylabel('CL');
title('Aerodynamic Polars');
legend('Cruise','Takeoff','Landing','Takeoff no gear','Landing no gear','Location','southeast')
grid on
grid minor

