%rakete laden

breakout_case3 = 0;
breakout_neu = 0;

           while breakout_case3 == 0
            dict = 1;
            raketenlister
            disp(liste)
            prompt = 'welche Rakete soll geflogen werden? "exit" um Menü zu verlassen ';
            raketenname = input(prompt, 's');
            if strcmp(raketenname, 'exit') == 1
                breakout_case3 = 1;
            else
                
            string = raketenname;
            stringcomp
            while breakout_neu == 0     
                
            if result == 0
                clc
                fprintf('Die Rakete %s ist nicht vorhanden. %s ',raketenname,raketenname)
                prompt = ('erstellen? [Y/N]');
                yesno
                if result == 1
                    breakout_neu = 1;
                    rakete_erstellen
                elseif result == 0
                    breakout_neu = 1;
                elseif result == 2
                    clc
                    string = 'biite [Y/N] angeben';
                    pulse
                else   
                    string = 'Fehler';
                    pulse
                end
            
            elseif result == 2
                disp('bitte Raketennamen eingeben')
            else
                current_rocket = raketenname;
                clc
                %string = 'Rakete wird in Simulation geladen...';
                %pulse ZEIT SPAREN
                fprintf('"%s" wurde geladen!', current_rocket)
                pause (1);
                breakout_case3 = 1;
                breakout_neu = 1;
            end
            end
            end
           end
           