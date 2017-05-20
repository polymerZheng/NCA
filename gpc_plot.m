function [] = gpc_plot( polymer )
%gpc_plot transform the molecular weight of every monomer to signal obey
%gaussian distribution.
sigma=1;
unit_weight=100;
polymer_amount=size(polymer,1);
weight=zeros(polymer_amount,1);
xarid=15:log(1.005):(15+log(100000));
yplot=zeros(size(xarid,1),1);
parfor i=1:polymer_amount
    weight(i)=polymer(i,:)*[unit_weight 0 45 44 45 44 44]';
    weight(i)=15+log(100000)-log(weight(i));
    signal=1./sqrt(2.*pi)./sigma*exp(-(xarid-weight(i)).^2./2./(sigma^2))*weight(i);
    yplot=yplot+signal;
end
figure(3)
plot(xarid,yplot);
hold off
end

