function [selectedPos] = posInput(presetNo)
found = 0;
list = ["Anna", "Braeden", "Cameron", "computer", "Corey"];
userName = getenv('username');
while(~found)
    
    f = figure('Name','Please select the best path');
    
    axes(f);
    for i = 1:5
        subplot(3,2,i);
        location = ['C:\Users\',userName,'\Documents\survey\results\'];
        userfolder = list(1,i);
        preset = string(presetNo);
        
        img_location = strcat(location, userfolder, '\', preset,'\',preset,'.jpg');
        img = imread(char(img_location));
        
        imshow(img);
    end
    
    drawnow();
    set_fig_position(f,0,0,1000,1000);
    ginput(1);
    pos = get(0,'PointerLocation')
    
    x = pos(1,1);
    y = pos(1,2);
    
    selectedPos = [];
    
    if (and(x >= 136, x <= 467))
        
        if(and(y <= 905, y >= 731))
            selectedPos = 1;
        end
        
        if(and(y <= 604, y >= 432))
            selectedPos = 3;
        end
        
        if(and(y <= 303, y >= 132))
            selectedPos = 5;
        end
        
    elseif(and(x >= 578, x <= 908))
        
        if(and(y <= 905, y >= 731))
            selectedPos = 2;
        end
        
        if(and(y <= 604, y >= 432))
            selectedPos = 4;
        end
        
    else
        selectedPos = 0;
    end
    
    if(selectedPos > 0)
        found = 1;
        delete(f);
    end
end

end
