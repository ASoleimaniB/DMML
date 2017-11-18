function [ x1 x2 y1 y2 ] = FindEdges( I )

for i=1:size(I,1)
    ISx1=find(I(i,:)==0);
    if ~isempty(ISx1)            
        x1=i;
        break
    end
end
for i=0:size(I,1)-1
    ISx2=find(I(end-i,:)==0);
    if ~isempty(ISx2)                                   
        x2=i;
        break
    end
end
for i=1:size(I,2)
    ISy1=find(I(:,i)==0);
    if ~isempty(ISy1)            
        y1=i;
        break
    end
end
for i=0:size(I,2)-1
    ISy2=find(I(:,end-i)==0);
    if ~isempty(ISy2)            
        y2=i;
        break
    end
end

x2=size(I,1)-x2;
y2=size(I,2)-y2;

end

