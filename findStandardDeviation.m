%% reset
clear all;
clc;
close all;
%% Load Participant Results

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

%% Extract Presets 2 & 3

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
%% Dist to centre

for i = 1:2
%     figure(i)
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
        
        meanValue = [mean(stepsX(step,:)),mean(stepsY(step,:))]
        
        distance2Mean = [];
        
        for stepTest = 1:length(stepsX(step,:))

            distance2Mean(1,stepTest) = sqrt((meanValue(1,1) - ...
                stepsX(step,stepTest))^2 + ...
                (meanValue(1,2) - stepsY(step,stepTest))^2);
            
        end
        
        figure(i);
        
        subplot(1,length(stepsX(:,1)),step);
        
        sigmaValue = std(distance2Mean);
        CentreMean = mean(distance2Mean);
        
%         ezplot(@(x) normpdf(x,0,sigmaValue),[-10,10]);
        values = normpdf([-10:0.1:10],CentreMean,sigmaValue);
        
        posValue = findPos(-10:0.1:10, CentreMean);
        yMax = values(1, posValue);
        plot([-10:0.1:10], values);
        
        
        titleName = {'Distance from centre',['Preset ',num2str(i + 1), ...
           ' Point: ', num2str(step), ' \mu = ' num2str(CentreMean),' \sigma = ', num2str(sigmaValue)]};
    
        title(titleName);
        xlabel("Data");
        ylabel("Probability");

        markerRangeX = [distance2Mean(1,4), distance2Mean(1,4)];
        markerRangeY = [0 yMax];

        hold on;
        plot(markerRangeX, markerRangeY);

        distance = abs(CentreMean - distance2Mean(1,4))/sigmaValue;

        leg = ['Computer Agent', newline, [num2str(distance),'*\sigma']];

        legend('Normal Distribution', leg);
        
    end
    
end


%% Calculate multivariate distribution
for i = 1:1
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
        figure(i);
        meanValue = [mean(stepsX(step,:)),mean(stepsY(step,:))];
        sigma = [std(stepsX(step,:)),(std(stepsY(step,:)))];
        
        x1 = -100:.5:100; x2 = -100:.5:100;
        [X1,X2] = meshgrid(x1,x2);
        
        sigmaUSE = cov([stepsX(step,:)',stepsY(step,:)']);
%         sigmaUSE = [1 -0;0 1];
        axisRange = [(meanValue(1,1) - 20) (meanValue(1,1) + 20), ...
            (meanValue(1,2) - 20) (meanValue(1,2) + 20) 0 .4];
        
        hold on;
        F = mvnpdf([X1(:) X2(:)],meanValue, sigmaUSE);
        F = reshape(F,length(x2),length(x1));
        surf(x1,x2,F);
        caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
        axis([0 100 0 40 0 0.4])
        
    end
    
end





