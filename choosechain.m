function [ num_polymer ] = choosechain( amount,need )
% to choose a chain with specified reaction site
global polymer;
count=randi(amount);
search_i=1;
while count>0
    num_polymer=search_i;
    count=count-polymer(search_i,need);
    search_i=search_i+1;
end
end

