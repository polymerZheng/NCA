function [ output_args ] = AMM( input_args )
% a program to stimulate the system where only AMM happen. For exampel, Et3
%N initiate the NCA
%========================================================================
%  vector species to represent the number of different active gourp (but not
%  really species!). the corespondece is shown as below:
% 1 NCA
% 2 NCA-
% 3 little amine
% 4 little amine+
% 5 amine end
% 6 carboxylic end
% 7 carboxylate anion end
% 8 NCA head in polymer or tadpole = linear polymer number
% 9 carboxylic group in middle unit
% 10 carboxylate anion in middle unit
%============================================================================
% reaction list as increasing number sorted
% 1) 1-2 AMM initation 
% 2) 1-3 deproptonation 1
% 3) 1-5 NAM propagtion type 1
% 4) 2-4 protonation 1 (reverse of 1-3)
% 5) 2-5 NAM propaagtion type 2
% 6) 2-8 AMM propagation at head of polymer
% 7) 3-6 deprotonation 2
% 8) 3-9 deprotonation 3
% 9) 4-7 protonation 2( reverse of 3-6)
% 10) 4-10 protonation 3 (reverse of 3-9)
% 11) 5-8 condensation 
% 12) 6 decarboxylation
% 13) 9 decarboxylation
% 13 reaction totaled corresponding to k[13]
%=========================================================================
%chain structure
% matrix polymer(i)(j) j=4
%   j     meaning                    value                        
%   1      DP                    natural number
%   2    amine end                 0-1
%   3    caroxylic end             0-1
%   4    carboxylate end           0-1
%   5    carboxylic in middle    natural number
%   6    carboxylate in middle   natural number
%   7    cyclic or linar           0-1
%==========================================================================
clc;
clear all;
%             ------------part I initiation----------
fprintf("initialtion of parameters...\n");
species=zeros(10,1);
species(1)=1000;
species(3)=100;
polymer=[];
global polymer
%polymer=zeros(10000,4);
rand('state', fix(mod(1e11*(sum(clock)-2017), 2^31)));

reaction=[1 2;1 3;1 5;2 4;2 5;2 8;3 6;3 9;4 7;4 10;5 8;6 0;9 0];
krate=ones(13,1);
krate(3)=100;
Volume_penalty=100000;
for i=1:size(krate,2)
    if reaction(i,2)==0
        krate(i)=krate(i)*Volume_penalty;
    end
end
%krate should have same row dimension with reaction

polymer_record=[0;0;0];
% 3 rows 1-Mn 2-Mw 3-PDI
time_record=[0];
species_record=species;
tadpole_record=[0];
%          -------------part II propagation-------------
fprintf("Stimulation of propagation begin...\n");
while species(1)>100
    %these two fuction can be used in other programs to determine which
    %reaction happen
    R_apparent=rate_calculation(species,krate,reaction);
    [reaction_type,step_time]=judgement(R_apparent);
    % use the label of reaction to manipulate the vector record the species
    species=state_transition(reaction_type,reaction,species);
    %record the change and state now
    time_record=[time_record,time_record(end)+step_time]; 
    species_record=[species_record species];
    tadpole_number=size(find(polymer(:,1)==2),2);
    tadpole_record=[tadpole_record, tadpole_number];
    [Mn,Mw,PDI]=polymer_calculation(polymer);
    temp=[Mn,Mw,PDI];
    polymer_record=[polymer_record temp'];
end
%          -------------part II characterazition-------------
fprintf("Painting begin...\n");
size(time_record,2)
size(polymer_record(1,:),2)
figure(1)
plot(time_record, polymer_record(1,:));
hold on
plot(time_record, polymer_record(2,:));
hold off
figure(2)
plot(time_record, polymer_record(3,:));
hold off
gpc_plot(polymer);
end


