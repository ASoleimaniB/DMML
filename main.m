% This is the MATLAB code for "Deep Multitask Metric Learning for Offline Signature Verification", a paper published in Pattern Recognition Letters
% 
% To become familiar with the structure of the code, you should look at the paper:
% A Soleimani, Amir, Babak N. Araabi, and Kazim Fouladi. "Deep multitask metric learning for offline signature verification." Pattern Recognition Letters, 2016

% 
clc; close all; clear;
p=1;
for it_=1:1
    close all;    
    save('it','it_');
    clear 
    load it
p=1;
% Number of classes. 115 in UTSig
TOTAL=115;
% load data\HOG_300_5_16_originalsacle_.mat
% HOG for UTSIG dataset
load HOG_300_5_16_originalsacle_ 
j=0; X_=[];

% Some preprocessing
X=X./max(X(:));
X=log(10*X+1);
X=PLC_115_t(X,.1); %Typo PCA

save('Xtemp','X')

N=size(X,2);

% ng: number of genuine signatures per class for training
% nf: number of forged signatures per class for training
ng=12; nf=5; 
ng_=12; nf_=5;

% P1 Number of Neurons in the hidden layer (shared layer)
% P2 Number of Neurons in the last layer (separed layers) for each class
P1=250; P2=250;
% parameters
tu=3; l=10^-2; beta=1;
mu=2*10^-3;
% the only parameter to stop training
iteration=20;

% making genuine and forged pairs
% xi xj train pairs
% y is the lable
% xi_t and xj_t pairs for test
% y_t is the lable
[ xi,xj,y,xi_t,xj_t,y_t ] = SkillForgOthers_RandForg(X,p,ng,nf,ng_,nf_);


Y=zeros(TOTAL*72,N);
for ii=1:72
    Y(TOTAL*(ii-1)+1:TOTAL*ii,:)=X(:,:,ii);
end
X=Y;
clear Y

Ns=size(xi,1);
% Initialize Weigths
% load W
W1=(rand(N,P1,TOTAL)*(2*sqrt(6)/(sqrt(N+P1))))-(sqrt(6)/(sqrt(N+P1)));
W2=(rand(P1,P2,TOTAL)*(2*sqrt(6)/(sqrt(P1+P2))))-(sqrt(6)/(sqrt(P1+P2)));
b1=rand(1,P1,TOTAL); b2=rand(1,P2,TOTAL);

%calc J
J=zeros(iteration+1,1);
J(1)=1;


for it=1:iteration    
    for i=1:TOTAL %NBatch
        if i~=0
        % 1st layer
        ind=(find(xi(:,1)==i));                
        hi0=X(Add(xi(ind,:)),:);
        hj0=X(Add(xj(ind,:)),:);
        % 1st Layer
        hi1=tanh(bsxfun(@plus,hi0*W1(:,:,1),b1(:,:,1)));
        hj1=tanh(bsxfun(@plus,hj0*W1(:,:,1),b1(:,:,1)));
        % 2nd Layer
        hi2=tanh(bsxfun(@plus,hi1*W2(:,:,i),b2(:,:,i)));
        hj2=tanh(bsxfun(@plus,hj1*W2(:,:,i),b2(:,:,i)));

        % Calc Gradients
        x=abs(hi2-hj2);
        df=sqrt(sum(x.^2,2)).^2;        
        clear x
        
        c=1-(y(ind).*(tu-df));
        clear df
        cr=Gr(c,beta);
        
        z1i=(bsxfun(@plus,hi0*W1(:,:,1),b1(:,:,1)));
        z1j=(bsxfun(@plus,hj0*W1(:,:,1),b1(:,:,1)));
        z2i=(bsxfun(@plus,hi1*W2(:,:,i),b2(:,:,i)));
        z2j=(bsxfun(@plus,hj1*W2(:,:,i),b2(:,:,i)));
       
        Dij2=(bsxfun(@times,(hi2-hj2).*Fr(z2i), cr.*y(ind)));
        Dji2=(bsxfun(@times,(hj2-hi2).*Fr(z2j), cr.*y(ind)));
        clear hi2 hj2 z2i z2j cr ind
        Dij1=(Dij2*W2(:,:,i)').*Fr(z1i);
        Dji1=(Dji2*W2(:,:,i)').*Fr(z1j);
        clear z1i z1j

    W1(:,:,1)=W1(:,:,1)-mu*((hi0'*Dij1 + hj0'*Dji1) +l*W1(:,:,1));
    b1(:,:,1)=b1(:,:,1)-mu*(sum(Dij1+Dji1,1) + l*b1(:,:,1));
    
    W2(:,:,i)=W2(:,:,i)-mu*((hi1'*Dij2 + hj1'*Dji2) +l*W2(:,:,i));
    b2(:,:,i)=b2(:,:,i)-mu*(sum(Dij2+Dji2,1) + l*b2(:,:,i));

        clear Dij1 Dji1 Dij2 Dji2

display([num2str(it) '->' num2str(i)])

        J(it+1)=J(it+1)+ .5* sum(G(c,beta));        

        end
        
    end
subplot(2,1,1)
plot(2:it+1,(J(2:it+1)),'k','LineWidth',2);
% cost function in the tilte (2 current errors)
title(['Training Cost Function: ', num2str(J(it+1)) ' | ' num2str(J(it+1)/J(it))]);
subplot(2,1,2)
[E(it+1) eer(it+1)]= f_AVR_115(ng,nf,ng_,nf_,W1,W2,b1,b2,TOTAL);
plot(2:it+1,(E(2:it+1)),'c',2:it+1,(eer(2:it+1)),'m');
legend('Average Error Ratio (AER)','Equal Error Ratio (EER)')
title('AER and EER on Test Set')
drawnow
% look at eer (here is magenta in the plot
end
% name=['eersave' num2str(it_) '.mat'];
% save(name,'eer','E');
end


