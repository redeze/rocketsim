%Startparameter laden

if exist('launchdata.mat', 'file') ~= 0
    load('launchdata')
    disp('Startparameter geladen...')
    pause(1);
else
    clc
    string = 'noch keine Startparameter vorhanden! Parameter müssen erstellt werden';
    pulse
end