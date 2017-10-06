function [selectedPos] = posInput(presetNo)
found = 0;
list = ["Anna", "Braeden", "Cameron", "computer", "Corey"];

while(~found)
    
    f = figure(1);
    axes(f);
    for i = 1:5
        subplot(3,2,i);
        location = ['C:\Users\Denis\Documents\survey\results\'];
        userfolder = list(1,i);
        preset = string(presetNo);
        
        img_location = strcat(location, userfolder, '\', preset,'\',preset,'.jpg');
        img = imread(char(img_location));
        
        imshow(img);
    end
    
    drawnow();
    
    ginput(1);
    pos = get(0,'PointerLocation');
    
    x = pos(1,1);
    y = pos(1,2);
    
    selectedPos = [];
    
    if (and(x >= 569.8, x <= 739.4))
        
        if(and(y <= 727.4, x >= 640.2))
            selectedPos = 1;
        end
        
        if(and(y <= 601, x >= 516.2))
            selectedPos = 3;
        end
        
        if(and(y <= 475.4, x >= 389.8))
            selectedPos = 5;
        end
        
    elseif(and(x >= 817.8, x <= 986.6))
        
        if(and(y <= 727.4, x >= 640.2))
            selectedPos = 2;
        end
        
        if(and(y <= 601, x >= 516.2))
            selectedPos = 4;
        end
        
    else
        selectedPos = 0;
    end
    
    if(selectedPos > 0)
        found = 1;
    end
end

end
