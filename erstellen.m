%erstellen

breakout_erstellen = 0;
while breakout_erstellen == 0
clc

disp('1, um Rakete zu erstellen')
disp('2, um Startsetup zu erstellen')
disp('3, um Planeten zu erstellen')
disp('0, um zum Hauptmenü zurückzukehren')

prompt = '\nEingabe...';

menu = input(prompt, 's');
num_test = isstrprop(menu,'digit');
    
if sum(num_test) == length(menu)
   menu = str2double(menu);
   switch menu
       case 1
           rakete_erstellen
       case 2
           startsetup_erstellen
       case 3
           planet_erstellen
       case 0
          breakout_erstellen = 1;
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