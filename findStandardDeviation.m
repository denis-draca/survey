%% reset
clear all;
clc;
close all;
%%

users = ["Anna", "Braeden", "Cameron", "computer", "Corey"];
userName = getenv('username');
savePath = ['C:\Users\',userName,'\Documents\survey\probabilityResults\'];

totalWaypoints = [];

for i = 1:length(users)
    currentUser = char(users(1,i));
    
    for x = 1:5
        
        preset = num2str(x);
        location = ['C:\Users\',userName,'\Documents\survey\results\'...
            ,currentUser,'\',preset,'\',currentUser,'.txt'];
        
        fid = fopen(location, 'r');
        
        startCount = 0;
        
        tline = fgetl(fid);
        totalCount = 0;
        
        while ischar(tline)
            
            if(strcmp(tline,'USER POINTS'))
                startCount = 1;
            end
            
            tline = fgetl(fid);
            
            if(startCount && ~strcmp(tline,'USER POINTS') && ischar(tline))
                totalCount = totalCount + 1;
            end
            
        end
        
        totalWaypoints(x,i) = totalCount;
        
        fclose(fid);
        
    end
    
end

%% Guassian Plot
for i = 1:length(totalWaypoints(:,1))
    f = figure(i);
    
    meanValue = mean(totalWaypoints(i,:));
    
    sigma = std(totalWaypoints(i,:));
    
    markerRangeX = [totalWaypoints(i,4),totalWaypoints(i,4)];
    markerRangeY = [0,1];
    
    ezplot(@(x) normpdf(x,meanValue,sigma),[0,10]);
    values = normpdf([0:0.1:10],meanValue,sigma);
    
    titleName = {'Waypoints to goal',['Preset ',num2str(i),' \mu = ' num2str(meanValue),' \sigma = ', num2str(sigma)]};
    
    title(titleName);
    xlabel("Data");
    ylabel("Probability");
    
    
    hold on;
    plot(markerRangeX, markerRangeY);
    
    distance = abs(meanValue - totalWaypoints(i,4))/sigma;
    
    leg = ['Computer Value', newline, [num2str(distance),'*\sigma']];
    
    legend('Normal Distribution', leg);
    
    saveLoc = [savePath,'Gaussian', num2str(i),'.jpg'];
    
    saveas(f,saveLoc);
    
end

%% Normal Plot

for i = 1:length(totalWaypoints(:,1))
    f = figure(i);
    
    meanValue = mean(totalWaypoints(i,:));
    
    sigma = std(totalWaypoints(i,:));
    
    normplot(totalWaypoints(i,:));
    
    titleName = {'Waypoints to goal',['Preset ',num2str(i),' \mu = ' num2str(meanValue),' \sigma = ', num2str(sigma)]};
    %
    title(titleName);
    
    saveLoc = [savePath,'Normal', num2str(i),'.jpg'];
    
    saveas(f,saveLoc);
    
    
end

%% Presets 2 & 3

users = ["Anna", "Braeden", "Cameron", "computer", "Corey"];
userName = getenv('username');
savePath = ['C:\Users\',userName,'\Documents\survey\probabilityResults\'];

for i = 1:length(users)
    currentUser = char(users(1,i));
    
    for x = 2:3
        
        preset = num2str(x);
        location = ['C:\Users\',userName,'\Documents\survey\results\'...
            ,currentUser,'\',preset,'\',currentUser,'.txt'];
        
        fid = fopen(location, 'r');
        
        startCount = 0;
        
        tline = fgetl(fid);
        totalCount = 0;
        values = [];
        
        while ischar(tline)
            
            if(strcmp(tline,'USER POINTS'))
                startCount = 1;
            end
            
            tline = fgetl(fid);
            if(startCount && ~strcmp(tline,'USER POINTS') && ischar(tline))
                valueTemp = strsplit(tline,',');
                totalCount = totalCount + 1;
                values(totalCount,1) = str2double(valueTemp{1});
                values(totalCount,2) = str2double(valueTemp{2});
                
            end
            
        end
        agent{i}.preset{x - 1} = values;
        
        fclose(fid);
        
    end
    
end

for i = 1:2
    figure(i)
    AllValues = [];
    stepsX = [];
    stepsY = [];
    for x = 1:length(users)
        
        userValues = agent{x}.preset{i};
        
        for step = 2:length(userValues(:,1)) - 1
            
            stepsX(step - 1, x) = userValues(step,1);
            stepsY(step - 1, x) = userValues(step,2);
            
        end
    end
    
    
    for step = 1:length(stepsX(:,1))
        %         hold on;
        
        meanValue = [mean(stepsX(step,:)),mean(stepsY(step,:))];
        sigma = [std(stepsX(step,:)),(std(stepsY(step,:)))];
        
        x1 = -3:.2:3; x2 = -3:.2:3;
        [X1,X2] = meshgrid(x1,x2);
        
        F = mvnpdf([X1(:) X2(:)],meanValue,sigma);
        F = reshape(F,length(x2),length(x1));
        surf(x1,x2,F);
        caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
        axis([-3 3 -3 3 0 .4])
        
    end
    
end





