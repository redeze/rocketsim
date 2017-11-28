clc
clear
close all

breakout_main = 0;
current_rocket = 'keine';
current_startpara = 'keine';
current_planet = 'keiner';

while(breakout_main == 0)

clc

disp ('1, um Objekt zu erstellen')
disp ('2, um vorhandenes Objekt zu bearbeiten')
disp ('3, um Objekt zu laden')
disp ('4, um eine Simulation zu starten')
disp ('0, um das Programm zu beenden')


    fprintf ('\nmomentan aktive Rakete: %s', current_rocket);
    fprintf ('\nmomentan aktives Startsetup: %s', current_startpara);
    fprintf ('\nmomentan geladener Planet: %s', current_planet);
    prompt = '\nEingabe... ';

    menu = input(prompt, 's');
    num_test = isstrprop(menu,'digit');
    
    if sum(num_test) == length(menu)
        menu = str2double(menu);
    switch menu
       case 1
           erstellen
       case 2
           bearbeiten
       case 3 
            laden
       case 4
           starten
       case 0
          breakout_main = 1;
        otherwise
        clc
        string = 'Fehler: gültigen Befehl eingeben';
        %pulse DEV
    
    end
    else
        clc
        string = 'Fehler: gültigen Befehl eingeben';
        %pulse DEV
    end
    
end
