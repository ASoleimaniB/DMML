function [ x ] = HIST( Gmag,Gdir,Nbins )
bins=linspace(0,360,Nbins+1);
bins=bins(1:end-1);
gmag=Gmag(:);
gdir=Gdir(:); 
gdir=gdir+180;
[~, ind]= histc(gdir,bins);
Sum=zeros(Nbins,1);
for i=1:Nbins
    Sum(i)=sum( gmag(ind==i) );
end
x=abs(Sum);
end

