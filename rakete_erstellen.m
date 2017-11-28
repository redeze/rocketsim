%Rakete Erstellen Unterprogramm

clc;
breakout_erstellen = 0;

while(breakout_erstellen == 0)
    
prompt = ('Raketenname eingeben');
dlg_title = 'Neue Rakete';
raketenname = inputdlg(prompt,dlg_title, [1,50]);
raketenname = char(raketenname);

dir = 1;
objektlister
string = raketenname;
stringcomp

if result == 1
    clc
    disp('Name schon vergeben, Rakete muss umbenannt werden')
elseif result == 2
    clc
    disp('Bitte Namen eingeben')
else
    clc
    breakout_erstellen = 1;
end
end

%%


headers(1) = "startmasse";
headers(2) = "stufenanzahl";
headers(3) = "startschub";
headers(4) = "nutzlast";
headers(5) = "höhe";
headers(6) = "cw";
headers(7) = "strukturmasse_s2";
headers(8) = "drehkoeff";
headers(9) = "durchmesser";

ranges(1) = ">0";
ranges(2) = "1-5";
ranges(3) = ">0";
ranges(9) = ">0";

rocket(:,1) = headers;
rocket(:,3) = ranges;


fileName = raketenname;
cd Raketen;
xlswrite(fileName, rocket);
xlsopen(fileName);

clearvars rocket_specs answer answer2 answer3


