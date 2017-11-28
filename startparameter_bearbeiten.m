%startparameter_bearbeiten
clc
clearvars menu planeten_name planeten_liste;

if exist('launchdata.mat','file') ~= 0
    load launchdata
    vorhanden = 1;
else 
    vorhanden = 0;
end
  

breakout_startpara = 0;
while breakout_startpara == 0
    
    breakout_bearbeiten = 0;
    while breakout_bearbeiten == 0
        
if vorhanden == 1
prompt = ('Planeten bearbeiten? [Y/N]');
yesno
    if result == 2
        clc
        disp('Bitte mit [Y/N] antworten')
    else
        breakout_bearbeiten = 1;
    end
    
else
result = 1;
breakout_bearbeiten = 1;
end

    end

    if result == 1
        
    breakout_planeten = 0;
    while breakout_planeten == 0

    prompt = {'Durchmesser (km):', ...
          'Abstand zum Zentralgestirn (mio km):', ...
          'Dichte Planet (g/cm^3):', ...
          'Dichte Atmosphäre auf Referenzhöhe (kg/m^3):' ...
          'Gaskonstante R (J/(kg*K)):' ...
          'Temperatur auf Referenzhöhe (K):' ...
          'Rotationsperiode (h):'};
    dlg_title = 'Planet';
    defaultans = {'6376', '149', '5.585', '1.225', '287', '300', '23.93'};
    planetprops = inputdlg(prompt,dlg_title, [1,50], defaultans);

    planetprops = str2double(planetprops);
        clc
        if planetprops(1) <= 0
        disp('Fehler: Durchmesser des Planeten muss größer Null sein')
        pause(1)
        elseif planetprops(2) <= 0
        disp('Fehler: Abstand zum Zentralgestirn muss größer Null sein')
        pause(1)
        elseif planetprops(3) < 0 || planetprops(4) < 0
        disp('Fehler: Dichte muss positiv sein')
        pause(1)
        elseif planetprops(5) < 0
        disp('Fehler: Gaskonstante muss positiv sein!')
        pause(1)
        elseif planetprops(6) < 0
        disp('Fehler: hör auf die Physik in Frage zu stellen!')
        pause(1)
        elseif planetprops(7) < 0
        disp('Fehler: Rotationsperiode muss positiv sein')
        pause(1)
        else
        breakout_planeten = 1;
        end
    end
    
    
        breakout_plspeichern = 0;
        while breakout_plspeichern == 0
            prompt = ('Planet abspeichern? [Y/N]');
            yesno
            if result == 1
                breakout_planet_speichern = 0;
                breakout_plspeichern = 1;
                while breakout_planet_speichern == 0
                prompt = ('Planetenname eingeben ');
                planeten_name = input(prompt, 's');
                
                dict = 2;
                
                raketenlister
                string = planeten_name;
                stringcomp
                if result == 0
                    fileName = planeten_name;
                    cd Planeten;
                    xlswrite(fileName, planetprops);
                    cd('..');
                breakout_planet_speichern = 1;
                breakout_plspeichern = 1;
                elseif result == 1
                    clc
                    disp('Name schon vergeben, bitte anderen Namen eingeben')
                else
                    clc
                    disp('Bitte Namen eingeben')
                end
                end    
            elseif result == 0
                breakout_plspeichern = 1;
            else
                clc
                disp('Bitte mit [Y/N] antworten')
            end
        end

    elseif result == 0
    breakout_planeten = 1;
    else 
    disp('Bitte mit [Y/N] antworten')
    end
    
breakout_bearbeiten = 0;
while breakout_bearbeiten == 0 

if vorhanden == 1
clc
prompt = ('Launchsite und Flugmodus bearbeiten? [Y/N]');
yesno

    if result == 2
        clc
        disp('bitte mit [Y/N] antworten')
    else
        breakout_bearbeiten = 1;
    end
    
else 
result = 1;
breakout_bearbeiten = 1;
end
end

if result == 1
    
breakout_launchsite = 0;
while breakout_launchsite == 0
    
    
    prompt = {'Breitengrad der Startrampe', ...
          'Höhe über n.N der Startrampe (m)', ...
          'Startabweichung von der Vertikalen (Grad)', ...
          'Bewegung der Startrampe (m/s)' ...
          'Triebwerkszündung Verzögerung (s)'};
    dlg_title = 'Launchsite';
    num_lines = 1;
    defaultans = {'5', '200', '2', '0', '0'};
    launchsite = inputdlg(prompt,dlg_title, [1,50], defaultans);

    launchsite = str2double(launchsite);
    flightmode = menu('Flugmodus auswählen','ballistisch', 'geregelter Aufstieg','Mobilgerät','Tasteneingabe');


        if launchsite(1) < 0 || launchsite(1) > 90
        disp('Fehler: Breitengrad muss zwischen 0 und 90 Grad liegen')
        pause(1)
        elseif launchsite(3) < -90 || launchsite(3) > 90
        disp('Fehler: Abschusswinkel muss zwischen -90 und 90 Grad liegen')
        pause(1)
        elseif launchsite(4) ~= 0 && flightmode == 2
        disp('Fehler: geregelter Aufstieg nicht von sich bewegender Startrampe möglich!')
        elseif launchsite(3) ~= 0 && flightmode == 2 
        disp('Warnung: geneigte Startrampe und geregelter Aufstieg führen zu unsicheren Ergebnissen!')
        breakout_launchsite = 1;
        else
        breakout_launchsite = 1;
        end
        
        if flightmode == 2
        breakout_geregelt = 0;
            while breakout_geregelt == 0
            prompt = {'Drehbeginn über Boden (m)', ...
               'Einstellwninkel (0-90 Grad)', ...
               'Aggresivität (0:1)'};
            dlg_title = 'Regelparameter';
            num_lines = 1;
            defaultans = {'800', '5.5', '0.3'};
            input_parameters = inputdlg(prompt,dlg_title, [1,50], defaultans);

            input_parameters = str2double(input_parameters);

    if input_parameters(1) < 0
        disp('Fehler: Drehbeginn muss oberhalb der Erdoberfläche liegen')
    elseif input_parameters(2) < 0 || input_parameters(2) > 90
        disp('Fehler: Einstellwinkel muss zwischen 0 und 90 Grad liegen')
    elseif input_parameters(3) < 0 || input_parameters(3) > 1
        disp('Fehler: Aggressivität muss zwischen 0 und 1 liegen')
    else 
        breakout_geregelt = 1;
    end
    end
else
end


if flightmode == 3
breakout_mobile = 0;
    while breakout_mobile == 0
        prompt = {'Sensitivität der Eingabe (0:1)', ...
        'Postprocessing (0:1)'};
        dlg_title = 'Mobilgerät';
        num_lines = 1;
        defaultans = {'0.3', '0.7'};
        input_parameters = inputdlg(prompt,dlg_title, [1,50], defaultans);

        input_parameters = str2double(input_parameters);
        
    if input_parameters(1) < 0 || input_parameters(1) > 1
        disp('Fehler: Sensitivität muss zwischen 0 und 1 liegen')
    elseif input_parameters(2) < 0 || input_parameters(2) > 1
        disp('Fehler: Postprocessing muss zwischen 0 und 1 liegen')
    else
        breakout_mobile = 1;
    end
    end
else
end
end

elseif result == 0
    breakout_launchsite = 1;
else
    disp('Bitte mit [Y/N] antworten')
end


clc
fprintf('Startparameter wurden übertragen!')
if exist('planeten_name','var') ~= 0
    fprintf('\nStartplanet: %s',planeten_name)
else
end
fprintf('\nDurchmesser: %d km\nAbstand zum Zentralgestirn: %d Millionen km\nDichte Planet: %d g/cm^3\nDichte Atmosphäre: %d kg/m^3\nGaskonstante: %d J/(kg*K)\n3Temperatur auf Referenzhöhe: %d Kelvin\nRotationsperiode: %d Stunden\nENTER zum Fortfahren',planetprops(:))
input('');
clc
fprintf('Launchsite:\nBreitengrad: %d Grad\nHöhe über n.N: %d Meter\nAbschusswinkel: %d Grad\nStartgeschwindigkeit: %d m/s\nTriebwerksverzögerung: %d Sekunden\nENTER zum Fortfahren',launchsite(:))

switch flightmode
    case 1
        flugmodus_name = 'ballistisch';
        fprintf('\n\nFlugmodus: %s', flugmodus_name)
        input_parameters = {0};
    case 2
        flugmodus_name = 'geregelter Aufstieg';
        fprintf('\n\nFlugmodus: %s', flugmodus_name)
        fprintf('\nDrehbeginn: %d m\nEinstellwinkel: %d Grad\nAggressivität: %d', input_parameters(:))
    case 3
        flugmodus_name = 'Mobilgerät';
        fprintf('\n\nFlugmodus: %s', flugmodus_name)
        fprintf('\nSensitivität der Eingabe: %d \nPostprocessing: %d', input_parameters(:))
    case 4
        flugmodus_name = 'Tasteneingabe';
        fprintf('\n\nFlugmodus: %s', flugmodus_name)
        input_parameters = {0}; 
end

s = input('\nEnter zum Abspeichern, anderes zum Wiederholen', 's');

if isempty(s) == 1
    breakout_startpara = 1;
else
    clc
end
end

save('launchdata', 'planetprops','launchsite', 'flightmode','input_parameters');
clearvars s num_lines defaultans breakout_geregelt breakout_launchsite breakout_mobile breakout_startpara dlg_title flightmode flugmodus_name input_parameters launchsite prompt planetprops result breakout_planeten answer

