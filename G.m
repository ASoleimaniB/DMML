function [ z ] = G( z,beta )


z=(log(1+exp(beta*z)))/beta;


end

