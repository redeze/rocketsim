%Rakete bearbeiten

breakout = 0;

%welche Rakete
dict = 1;
raketenlister %schreibt alle vorhandenen Raketen in das Array 'liste'

while(breakout == 0)

disp(liste)
prompt = 'welche Rakete soll bearbeitet werden? ';
raketenname = input(prompt, 's');
%save('vergleich','raketenname','liste');
string = raketenname;
stringcomp %0, wenn nicht vorhanden; 1, wenn vorhanden; 2, leerer String

if result == 1
    breakout = 1;
    
    raketenname_ext = strcat(raketenname, '.xls');
    cd Raketen;
    winopen(raketenname_ext);
    cd('..');
    
    clc
    fprintf('ENTER, wenn Bearbeitung von %s abgeschlossen!', raketenname)
    input('')
elseif result == 2
    disp('bitte Raketennamen eingeben')
elseif strcmp(raketenname, 'exit') == 1
    breakout = 1;
else
    clc
    disp ('bitte vorhandene Rakete eingeben')
    
end
end