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
    set_fig_position(f,0,0,700,1000);
    drawnow;
    
    ginput(1);
    pos = get(0,'PointerLocation');
    
    x = pos(1,1);
    y = pos(1,2);
    
    selectedPos = [];
    
    if (and(x >= 158, x <= 445))
        
        if(and(y <= 730, y >= 584))
            selectedPos = 1;
        end
        
        if(and(y <= 522, y >= 372))
            selectedPos = 3;
        end
        
        if(and(y <= 313, y >= 164))
            selectedPos = 5;
        end
        
    elseif(and(x >= 597, x <= 885))
        
        if(and(y <= 730, y >= 584))
            selectedPos = 2;
        end
        
        if(and(y <= 522, y >= 372))
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
