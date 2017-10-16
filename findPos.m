function [ firstPos ] = findPos(list, value)

for i = 1:length(list)
    
    if(list(i) < (value + 0.01) && list(i) > (value - 0.01))
       firstPos = i;
       return;
    end
    
end

disp("Not Found");

end

