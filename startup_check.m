%startup_check
load launchdata
if exist('current_rocket', 'var') == 0
    clc
    string = 'Simulation kann nicht gestartet werden, keine Rakete geladen!';
    pulse
elseif exist('launchdata.mat','file') == 0
    clc
    string = 'launchdata.mat existiert nicht, bitte Startparameter hinzufügen!';
    pulse

else
    if menu == 7
       if flightmode == 3 || flightmode == 4
            clc
            string = 'QuickSim kann nicht gestartet werden, bitte Flugmodus ändern';
            pulse
            return
       else 
       end
    end
    [startup_return, failure_string] = liftoff_check(current_rocket);
    
    if startup_return == 1
        fprintf('%s ist abflugbereit!', current_rocket)
        pause(1)
        if menu == 6
            delta_v_sim
        elseif menu == 7
            quicksim
        else
            echtzeit_sim
        end
    else
        clc
        string = failure_string;
        pulse
    end
end

function [startup_return, failure_string] = liftoff_check(current_rocket)            
save('current','current_rocket');
clc
clear
load('current');
cd Raketen
[raw,txt,num] = xlsread(current_rocket);
rocket_specs = num;
clearvars raw txt num
cd('..')

%Überprüfung, ob Rakete abhebt

%result = 0 wenn Fehler
failure_string = 'Nicht genügend Startschub'; %Fehlermeldung
startup_return = 1; %wenn alles OK

end

%save('startup_result','startup_string','startup_return');

