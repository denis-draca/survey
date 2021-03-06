participants = ["Daniela", "Andrew", "Matt", "Somaia", "Savvas"];

results = [];
userName = getenv('username');

for i = 1:length(participants)
    name = char(participants(1,i));   
    readings = csvread(['C:\Users\',userName,'\Documents\survey\surveyResults\',name,'.txt']);

    for x = 1:length(readings(:,1))
        
        line = readings(x,1:15);
            
        preset = [line(1:3);line(4:6);line(7:9);line(10:12);line(13:15)];
        
        results{i}.presetResult(:,:,x) = preset;  
    end
    
    results{i}.best = readings(:,16);
end

%%
for i = 1:length(results)
   
    presetResults = results{i}.presetResult;
    
    user1 = 0;
    user2 = 0;
    user3 = 0;
    user4 = 0;
    user5 = 0;
    for x = 1:length(presetResults)
        
        currentPreset = presetResults(:,:,x);
        
        user1 = user1 + sum(currentPreset(1,:));
        user2 = user2 + sum(currentPreset(2,:));
        user3 = user3 + sum(currentPreset(3,:));
        user4 = user4 + sum(currentPreset(4,:));
        user5 = user5 + sum(currentPreset(5,:));
        
        
        
    end
    f1 = figure('Name', 'Total Score');
    
    y = [user1,user2,user3,user4,user5];
        
    bar(y);
    
    xlabel("Agent (4 = Computer Agent)");
    ylabel("Total Score");
    title("Particpant " + string(i) + " Score given to each agent");
    
    f2 = figure('Name','Best');
    
    count = zeros(1,5);
    for x = 1:length(results{i}.best)
        count(1,results{i}.best(x,1)) = count(1,results{i}.best(x,1)) + 1;
    end
    
    bar(count);
    
    xlabel("Agent (4 = Computer Agent)");
    ylabel("Times selected as best");
    title("Particpant" + string(i) + " choices");
    name = char(participants(1,i));  
    
    saveas(f1,['C:\Users\',userName,'\Documents\survey\saved figures\score',name,'.jpg']);
    saveas(f2,['C:\Users\',userName,'\Documents\survey\saved figures\best',name,'.jpg']);
    
end


%% Average per person

user1 = 0;
user2 = 0;
user3 = 0;
user4 = 0;
user5 = 0;

count = zeros(1,5);

for i = 1:length(results)
   
    presetResults = results{i}.presetResult;
    for x = 1:length(presetResults)
        
        currentPreset = presetResults(:,:,x);
        
        user1 = user1 + sum(currentPreset(1,:));
        user2 = user2 + sum(currentPreset(2,:));
        user3 = user3 + sum(currentPreset(3,:));
        user4 = user4 + sum(currentPreset(4,:));
        user5 = user5 + sum(currentPreset(5,:));
            
    end
      
    for x = 1:length(results{i}.best)
        count(1,results{i}.best(x,1)) = count(1,results{i}.best(x,1)) + 1;
    end
    
end
f1 = figure('Name', 'Total SCORE');
y = [user1,user2,user3,user4,user5];
bar(y);
f2 = figure('Name','Total BEST');
bar(count);

f3 = figure('Name', 'Average SCORE');
bar(y./length(results));

f4 = figure('Name', 'Average BEST');
bar(count./length(results));


saveas(f1,['C:\Users\',userName,'\Documents\survey\saved figures\totalScore.jpg']);
saveas(f2,['C:\Users\',userName,'\Documents\survey\saved figures\totalBest.jpg']);
saveas(f3,['C:\Users\',userName,'\Documents\survey\saved figures\averageScore.jpg']);
saveas(f4,['C:\Users\',userName,'\Documents\survey\saved figures\averageBest.jpg']);
