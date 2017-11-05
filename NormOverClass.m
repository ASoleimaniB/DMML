function [ X ] = NormOverClass( X,ng )


j=0;
X_=[];
for i=1:size(X,2)
    A=(max(max(X(:,i,1:ng))));
    if A~=0
        j=j+1;
        X_(:,j,:)=X(:,i,:)./A;            
    end
end
X=X_;


end

