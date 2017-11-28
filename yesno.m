%yesno

%prompt = 'Teststring? [Y/N]'
answer = input(prompt, 's');

if answer == 'Y'
    result = 1; %True
elseif answer == 'N'
    result = 0; %False
else
    result = 2; %Fehler
end
