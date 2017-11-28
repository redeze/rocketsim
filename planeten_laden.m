%Planeten laden
clc
breakout_planet = 0;

dict = 2;

           while breakout_planet == 0
               
            breakout_neu = 0;
            fprintf('\n\n')
            raketenlister
            disp(liste)
            prompt = 'auf welchem Planeten soll gestartet werden? "exit" um Menü zu verlassen ';
            planeten_name = input(prompt, 's');
            if strcmp(planeten_name, 'exit') == 1
                breakout_planet = 1;
            else
                
            string = planeten_name;
            stringcomp
            while breakout_neu == 0     
                
            if result == 0
                clc
                fprintf('\nDer Planet %s ist nicht vorhanden.',planeten_name)
                breakout_neu = 1;
            
            elseif result == 2
                disp('bitte Planetennamen eingeben')
            else
                current_planet = planeten_name;
                clc
                %string = 'Planet wird in Simulation geladen...';
                %pulse ZEIT SPAREN
                fprintf('"%s" wurde geladen!', current_planet)
                pause (1);
                breakout_planet = 1;
                breakout_neu = 1;
            end
            end
            end
           end
           
           clearvars anzahl breakout_neu breakout_planet dict i liste prompt result string_lower
           