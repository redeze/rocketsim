%Stringcomp

string_lower = lower(string);
liste_lower = lower(liste);
check_vorhanden = ismember(string_lower,liste_lower);
check_leer = isempty(string);

if check_vorhanden == 1 %wenn Rakete existiert
    result = 1;
elseif check_leer == 1 %wenn String leer ist
    result = 2;
else %wenn Rakete nicht existiert oder sonst.
    result = 0;
end

clearvars check_leer check_vorhanden raketenname_lower liste_lower