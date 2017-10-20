function [ firstPos ] = findPos(list, value)

for i = 1:length(list)
    
    if(list(i) < (value + 0.1) && list(i) > (value - 0.1))
       firstPos = i;
       return;
    end
    
end

disp("Not Found");

end

