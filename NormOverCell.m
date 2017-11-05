function [ X ] = NormOverCell( X,EACH,Win )

% EACH=16;

for i=1:75
    for j=1:30
        for k=1:Win
        A=sum(X(i,(k-1)*EACH + 1 : (k)*EACH,j));
        if A==0
            A=1;
        end
        X(i,(k-1)*EACH + 1 : (k)*EACH,j)=X(i,(k-1)*EACH + 1 : (k)*EACH,j)./A;
        end
    end
end

end

