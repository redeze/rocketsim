%echtzeit_sim

%temporär

save('variablen','current_rocket','planetprops','input_parameters','launchsite','flightmode')
clc
clear
load variablen
cd Raketen
[raw,txt,num] = xlsread(current_rocket);
cd('..')
rocket_specs(:) = num(:,2);
clearvars raw txt

n = max(size(rocket_specs));

%%

%Rakete
   
    A = zeros(1, n);
for k = 1 : n
    if iscellstr(rocket_specs(k)) == 1
        A(k) = str2double(rocket_specs(k));
    else
    A(k) = cell2mat(rocket_specs(k));
    end
end

test1 = A(1);
n_booster = A(2);
test3 = A(3);
H_B = A(4);
D_B = 1;
n_steuer = 4;
A_Ruder = 5.4;
F_1 = 50000;
F_B = 70000;
H_1 = 20;
D_1 = 1.5;
H_2 = 15;
D_2 = 1.5;
H_3 = 10;
D_3 = 1;
H_4 = 0;
D_4 = 0;
H_5 = 0;
D_5 = 0;

%%
%Flightmode

%Variablen auslesen
if flightmode == 3
    f13 = input_parameters(1);
    f23 = input_parameters(2);
elseif flightmode == 2
    f12 = input_parameters(1);
    f22 = input_parameters(2);
    f32 = input_parameters(3);
else
end

%%
%Planet
durchmesser_planet = planetprops(1)*10^3;
abstand_planet = planetprops(2)*10^6;
rhoP = planetprops(3);
rho0 = planetprops(4);
R_gaskonst = planetprops(5);
global T0;
T0 = planetprops(6);
rotationsperiode = planetprops(7);
global kappa
kappa = 1.4; %in Planetprops übertragen
global p0
p0 = rho0 * R_gaskonst * T0;

%%

% Launchsite

breitengrad = launchsite(1);
starthoehe = launchsite(2);
startwinkel = launchsite(3);
v_startrampe = launchsite(4);
s1_delay = launchsite(5);

clearvars  A num k anzahl_var n %später: input_parameters planetprops rocketspecs launchsite

%%globale Variablen
global gravi_kon
gravi_kon = 6.674*10^(-11);
%%Planetenmasse
global r_planet
r_planet = durchmesser_planet/2;
global m_planet
m_planet = rhoP * 4/3*pi*(r_planet/2)^3*10^3;
global g0
g0 = gravi_kon * m_planet / ((r_planet)^2);

startwinkel_rad = startwinkel / 180 * pi;
durchmesser_planet_bg = cos(startwinkel_rad) * durchmesser_planet;
v0 = v_startrampe + pi * durchmesser_planet_bg / (rotationsperiode * 3600);

y = [v0, 0, durchmesser_planet + starthoehe, 0]; %Startvektor
t = 0;

ttable = [0 120;120 400;405 550];

%Richtungssteuerung
%Stufeneigenschaften: Fins 0 1, Anzahl, Fläche m^2, Steuerung (Grad), Gimbal (Grad)

%Thrust-Steuerung
%Es ist schwer, vor dem Start die Zeitpunkte der Stufenzündung zu bestimmen
%Lösung: Angabe eines Zielorbit (SCHWER!) dazu muss bekannt sein: Time to apogee,
%Burntime estimate anhand von delta v / s bzw delta v / Brenndauer, 
%Vektorsteuerung während des Burnprozesses
%
%
%
%Schubkraftberechnung
%Flugphasen:
%1. Stufe + Booster
%1. Stufe
%2. Stufe
%3. Stufe
%4. Stufe
%5. Stufe
%Den Flugphasen werden vor dem Start die zeiträume zugeordnet
%-->Schleifensteuerung über t
%2x7 Matrix mit Beginn und Ende der jeweilige Stufe, Ende der vorherigen Stufe, 
%wenn es die Stufe nicht gibt
h = y(3) - r_planet;
orbit_check = 0;
p0 = R_gaskonst * T0 / rho0;

while h>=0 || orbit_check == 0 

    
v_vec = [y(1); y(2)];
v_ges = sqrt(y(1)^2 + y(2)^2);
h = sqrt(y(3)^2 + y(4)^2) - r_planet; %Höhe über 0
phi = atan(y(4)/y(3)); %Position um Gestirn
alpha = 1;

[p,rho,T] = atmosphaerenfunktion(h);
g = gravitationsfunktion(h);

%Steuerkaft Berechnung
if flightmode == 1 %ballistisch
    F_Steuer = 0;
elseif flightmode == 2 %geregelt
    F_Steuer = 
elseif flightmode == 3 %mobilgerät
    F_Steuer = 
elseif flightmode == 4 %Tastensteuerung
    F_Steuer = 
    

%AKTUELL: 5 m/s auf Bodenhöhe, zunehmend auf 100 m/s auf 20000m
%GEPLANT: windsimulation nur unter 20000m für performance. jetstream auf 10000m höhe
%maximal 300 km/h. startwind bis 20 km/h. wind wird im sekundentakt mit
%böen simuliert. weicher übergang ???
v_wind = wind(h)

%Seitenfläche Booster
switch n_booster
    case 0
        A_B = 0;
    otherwise
        A_B = H_B * D_B * 2;
end

%Seitenfläche Steuerflächen
switch n_steuer
    case 0
        A_S = 0;
    otherwise
        A_S = 2 * A_Ruder;
end

%Seitenfläche Gesamtrakete inkl Booster und Finnen
if t<ttable(1,1)
    F_Schub = 0;
    A_Seite = H_1 * D_1 + A_S + A_B + H_2 * D_2 + H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges;
elseif t<ttable(1,2)
    F_Schub = F_1 + n_booster * F_B;
    A_Seite = H_1 * D_1 + A_S + A_B + H_2 * D_2 + H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - (t-ttable(1,1) * mpunkt_booster * n_booster + mpunkt_s1);
elseif t<ttable(2,2)
    F_Schub = F_1;
    A_Seite = H_1 * D_1 + A_S + H_2 * D_2 + H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - (t-ttable(1,1) * mpunkt_s1) - n_booster * m_ges_booster;
elseif t<ttable(3,1)
    F_Schub = 0;
    A_Seite = H_2 * D_2 + H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster;
elseif t<ttable(3,2)
    F_Schub = F_2;
    A_Seite = H_2 * D_2 + H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - (t-ttable(3,1) * mpunkt_s2);
elseif t<ttable(4,1)
    F_Schub = 0;
    A_Seite = H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2;
elseif t<ttable(4,2)
    F_Schub = F_3;
    A_Seite = H_3 * D_3 + H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - (t-ttable(4,1)*mpunkt_s3);
elseif t<ttable(5,1)
    F_Schub = 0;
    A_Seite = H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - m_ges_s3;
elseif t<ttable(5,2)
    F_Schub = F_4;
    A_Seite = H_4 * D_4 + H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - m_ges_s3 - (t-ttable(5,1)*mpunkt_s4);
elseif t<ttable(6,1)
    F_Schub = 0;
    A_Seite = H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - m_ges_s3 - m_ges_s4;
elseif t<ttable(6,2)
    F_Schub = F_5;
    A_Seite = H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - m_ges_s3 - m_ges_s4 - (t-ttable(6,1)*mpunkt_s5);
else
    F_Schub = 0;
    A_Seite = H_5 * D_5;
    m = m_ges - m_ges_s1 - n_booster * m_ges_booster - m_ges_s2 - m_ges_s3 - m_ges_s4 - m_ges_s5;
    
end


%Schrittweitensteuerung

if F_Schub == 0 && h > 200000
    dt = 1;
elseif F_Schub == 0 && h > 30000
    dt = 0.2;
else
    dt = 0.05;
end

%Zeitbeschleunigung
%muss jederzeit geändert werden können
%hat Einfluss auf dt
%setzt Flugmodus zu ballistisch

if timeacc ~= 1
    flightmode = 1; %ballistisch
    dt = timeacc*dt; %lineare skalierung des Zeitschrittes
else
end

%Flightpath-Projector
%zeigt den kräftefreien Flugweg an
%farbig hervorgehoben (figure)
%Problem: eigene Integrationsaufgabe
%geschlossen lösbar? input: Flugvektor ouput: Flugweg
%abhängig von: g ... ?

%%

%mehrere Objekte simulieren
%zeigt den unbeschleunigten Flugweg von Boostern/Unterstufen nach der
%Trennung an
%Atmosphäre muss berücksichtigt werden: Integration
%Euler reicht
%jedes Objekt bekommt eine fortlaufende ID, die in einer forschleife mit
%Euler integriert wird, bis h<0
%Ausrichtung/Seitenkräfte/Wind mitsimulieren?

%WIND-Generator
%erzeugt einen Seitenwind abhängig von einem Launchwindfaktor (0,1) und der
%Höhe. Normalverteilt/stetig fortgesetzt
%Wind wird mit Seitenprojektionsfläche der Rakete multipliziert, Dichte
%berücksichtigen


end


function dy_schlange = Euler(y,dt,Fx1,Fx2,m)

    dy_schlange(1) = (Fx1/m)*dt;
    dy_schlange(2) = (Fx2/m)*dt;
    dy_schlange(3) = y(1)*dt;
    dy_schlange(4) = y(2)*dt;
end

function dy = Heun(y,dt,Fx1,Fx2,m)

    dy_schlange = Euler(y,dt);


    dy(1) = (Fx1/m)*dt/2 + dy_schlange(1);
    dy(2) = (Fx2/m)*dt/2 + dy_schlange(2);
    dy(3) = y(1)*dt/2 + dy_schlange(3);
    dy(4) = y(2)*dt/2 + dy_schlange(4);


end

function v_wind = wind(h)

if h<20000
   v_wind = 5 + 0.005*h;
else
   v_wind = 0;
end
end


function [p,rho,T] = atmosphaerenfunktion(h)
global T0 R_gaskonst p0 r_planet
    T1 = T0 - 82.5; %217.5
    T2 = T1 + 55.5; %270
    T3 = T2 - 90; %180

    if h < 15000
        T = T0 - 0.0055 * h;
    elseif h < 50000
        T = T1 + 4.53*(10^-8)*(h-15000)^2;
    elseif h < 80000
        T = T2 - 0.003 * (h-50000);
    elseif h < 200000
        T = T3 + 0.0068086 * (h-80000);
    else
        T = T0 + 700;
    end
    
p = p0 * exp(-h/r_planet);
rho = 1% p/(R_gaskonst*T);

end

function g = gravitationsfunktion(h)
global m_planet r_planet gravi_kon

    g = gravi_kon * m_planet / ((r_planet + h)^2);

end