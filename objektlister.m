%Objektlister

switch dir
    case 1
        cd Raketen;
        liste_struct = 'Raketen';
    case 2 
        cd Startparameter;
        liste_struct = 'Startparameter';
    case 3
        cd Planeten;
        liste_struct = 'Planeten';
    otherwise
        disp('Dir nicht vorhanden')
        input('');
end

liste = ls;
liste(1) = [];
liste(1) = [];
liste = erase(liste, '.xls');
cd('..');

switch dir
    case 1
        raketen_liste = liste;
    case 2
        startpara_liste = liste;
    case 3
        planeten_liste = liste;
    otherwise
        disp('Directionary nicht vorhanden')
end

clearvars liste_struct;
%save('raketenlister', 'liste');