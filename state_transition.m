function [species] = state_transition(reaction_type,reaction,species)
global polymer
switch reaction_type
    case 1
        polymer=[polymer;2,0,0,1,0,0,1];
        species(8)=species(8)+1;
        species(7)=species(7)+1;
    case 2
        species(2)=species(2)+1;
        species(4)=species(4)+1;
    case 3
        num_polymer=choosechain(species(5),2);
        polymer(num_polymer,1)=polymer(num_polymer,1)+1;
        polymer(num_polymer,2)=0;
        polymer(num_polymer,3)=1;
        species(6)=species(6)+1;
    case 4
        species(1)=species(1)+1;
        species(3)=species(3)+1;
    case 5
        num_polymer=choosechain(species(5),2);
        polymer(num_polymer,1)=polymer(num_polymer,1)+1;
        polymer(num_polymer,2)=0;
        polymer(num_polymer,4)=1;
        species(7)=species(7)+1;
    case 6
        num_polymer=choosechain(species(8),7);
        polymer(num_polymer,1)=polymer(num_polymer,1)+1;
        polymer(num_polymer,6)=polymer(num_polymer,6)+1;
        species(8)=species(8)+1;
        species(10)=species(10)+1;
    case 7
        num_polymer=choosechain(species(6),3);
        polymer(num_polymer,3)=0;
        polymer(num_polymer,4)=1;
        species(4)=species(4)+1;
        species(7)=species(7)+1;
    case 8
        num_polymer=choosechain(species(9),5);
        polymer(num_polymer,5)=polymer(num_polymer,5)-1;
        polymer(num_polymer,6)=polymer(num_polymer,6)+1;
        species(4)=species(4)+1;
        species(10)=species(10)+1;
    case 9
        num_polymer=choosechain(species(7),4);
        polymer(num_polymer,4)=0;
        polymer(num_polymer,3)=1;
        species(3)=species(3)+1;
        species(6)=species(6)+1;   
    case 10
        num_polymer=choosechain(species(10),6);
        polymer(num_polymer,6)=polymer(num_polymer,6)-1;
        polymer(num_polymer,5)=polymer(num_polymer,5)+1;
        species(3)=species(3)+1;
        species(9)=species(9)+1;    
    case 11
        num_polymer1=choosechain(species(5),2);
        num_polymer2=choosechain(species(8),7);
        if num_polymer1~=num_polymer2
            polymer(num_polymer1,[1 5 6])=polymer(num_polymer1,[1 5 6])+...
               polymer(num_polymer2,[1 5 6]);
            polymer(num_polymer1,[2 3 4 7])=polymer(num_polymer2,[2 3 4 7]);
            polymer(num_polymer2,:)=polymer(end,:);
            polymer(end,:)=[];
        else
            polymer(num_polymer1,[2 3 4 7])=[0 0 0 0];
        end
        polymer(num_polymer1,5)=polymer(num_polymer1,5)+1;
        species(9)=species(9)+1;
    case 12
        num_polymer=choosechain(species(6),3);
        polymer(num_polymer,[2 3])=[1 0];
        species(5)=species(5)+1;
    case 13 
        num_polymer=choosechain(species(9),5);
        polymer(num_polymer,5)=polymer(num_polymer,5)-1;
end
x=reaction(reaction_type,1);
y=reaction(reaction_type,2);
species(x)=species(x)-1;
if y~=0
    species(y)=species(y)-1; 
end
