function [ J ] = Cost( xi,xj,y,W1,W2,b1,b2,beta,tu,l )

xi1=F(bsxfun(@plus,xi*W1,b1));
xj1=F(bsxfun(@plus,xj*W1,b1));
xi2=F(bsxfun(@plus,xi1*W2,b2));
xj2=F(bsxfun(@plus,xj1*W2,b2));
x=abs(xi2-xj2);
df=sqrt(sum(x.^2,2)).^2;
J=.5* sum(G(1-y.*(tu-df),beta))...
    + (.5*l*( norm(W1,'fro')^2+norm(W2,'fro')^2+ norm(b1)^2 + norm(b2)^2));


end

