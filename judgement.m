function [reaction_type,step_time] = judgement(R_apparent)
%Use R_apparent to calculte the type of reaction and step_time
R_amount=sum(R_apparent,2);
step_time=log(1/rand(1,1))/R_amount;
R_apparent./R_amount;
reaction_type=randsrc(1,1,[1:size(R_apparent,2);R_apparent./R_amount]);
end

