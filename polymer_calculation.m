function [Mn,Mw,PDI] = polymer_calculation(polymer)
unit_weight=100;
polymer_amount=size(polymer,1);
weight=zeros(polymer_amount,1);
parfor i=1:polymer_amount
    weight(i)=polymer(i,:)*[unit_weight 0 45 44 45 44 44]';
end
weight_amount=sum(weight);
weight_square_amount=sum(weight.^2);
Mn=weight_amount/polymer_amount;
Mw=weight_square_amount/weight_amount;
PDI=Mw/Mn;
end

