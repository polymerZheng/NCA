function [ R_apparent ] = rate_calculation( species,krate,reaction )
%use reaction matrix to pick up the data from species and calculate the
%Reaction rate with krate
reaction_number=size(reaction,1);
R_apparent=zeros(1,reaction_number);
for i=1:reaction_number
    if reaction(i,2)~=0
        R_apparent(i)=species(reaction(i,1))*species(reaction(i,2))*krate(i);
    else
        R_apparent(i)=species(reaction(i,1))*krate(i);
    end
end

