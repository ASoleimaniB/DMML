function [ E,eer ] = f_AVR(ng,nf,ng_,nf_,W1,W2,b1,b2,TOTAL)
load Xtemp
dis=[];
% save('X20_16','X')
for p=1:TOTAL
    
[ xi_t,xj_t,y_t ] = SkillForgOthers_random_test(X,p,ng,nf,ng_,nf_);
hi1=F(bsxfun(@plus,xi_t*W1(:,:,1),b1(:,:,1)));
hj1=F(bsxfun(@plus,xj_t*W1(:,:,1),b1(:,:,1)));
hi2=F(bsxfun(@plus,hi1*W2(:,:,p),b2(:,:,p)));
hj2=F(bsxfun(@plus,hj1*W2(:,:,p),b2(:,:,p)));
x=abs(hi2-hj2);
df=sqrt(sum(x.^2,2)).^2;

for i=1:size(df,1)/ng
    dis_min(i)=min(df((ng*(i-1))+1:ng*i));
    dis_mean(i)=mean(df((ng*(i-1))+1:ng*i));
    dis_max(i)=max(df((ng*(i-1))+1:ng*i));
end

FRR(p)=(27-ng-length(find(dis_min(1:27-ng)<2)))/(27-ng);
FAR(p)=length(find(dis_min(27-ng+1:end)<2))/(45);
AVR(p)=mean([FRR(p) FAR(p)]);



dis(p,:)=dis_min;
end
[ eer , th] = EER_115( dis,ng );
MFRR=mean(FRR)
MFAR=mean(FAR)
E=mean(AVR);
end