function [ eer , th] = EER( dis_min,ng )




n=1001;
N=linspace(0,10,n);

for i=1:n
for j=1:75  
FRR(j,i)=(15-ng-length(find(dis_min(j,1:15-ng)<N(i))));
FAR(j,i)=length(find(dis_min(j,15-ng+1:end)<N(i)));
    
end
end
frr=sum(FRR,1)/((15-ng)*75);
far=sum(FAR,1)/(15*75);
d=abs(frr-far);
[a b]=min(d);
eer=mean([far(b) frr(b)]);
th=N(b);