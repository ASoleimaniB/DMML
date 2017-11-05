function [ x ] = Gr( x,beta )

x=exp(beta*x);
x=x./(x+1);
% x=exp(beta*x)./(exp(beta*x)+1);


end

