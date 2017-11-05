function [ X ] = PLC( X,N)


Y=zeros(115*12,size(X,2));
for ii=1:12
    Y(1+(115*(ii-1)):(115*ii),:)=X(:,:,ii);
end

% Y=normr(Y); %%%%%%%%%%%%%%%%%%%%%%%%%

[COEFF,SCORE] = pca(Y);
n=sqrt(sum(abs(SCORE).^2,1));
n=n/max(n);
N=length(find(n>N));
Amean=mean(Y);
% Y=Y - repmat(mean(Y),[size(Y,1) 1]);
% Y=Y*COEFF(:,1:N);
Y=zeros(115*72,size(X,2));
for ii=1:72
    Y(1+(115*(ii-1)):(115*ii),:)=X(:,:,ii);
end
Y=Y - repmat(Amean,[size(Y,1) 1]);
Y=Y*COEFF(:,1:N);
% Y=SCORE(:,1:N);
X=zeros(115,N,72);
for ii=1:72
%     for jj=1:115
    X(:,:,ii)=Y(115*(ii-1)+1:115*ii,:);
%     end
end


end

