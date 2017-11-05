function [ xi,xj,y,xi_t,xj_t,y_t ] = RandomForg(X,p,ng,nf )

N=size(X,2); 
xis= ((ng)*(ng-1)/2 )+ng + (ng*nf*114);
xi=zeros(xis,N); xj=zeros(xis,N); y=zeros(xis,1);
c=0;
%% Train
% genuine
for i=1:ng
    for j=i:ng
        c=c+1;
        xi(c,:)=reshape(X(p,:,i),N,1,1)';
        xj(c,:)=reshape(X(p,:,j),N,1,1)';
        y(c,:)=1;
    end
end
% Random Forgery
for i=1:ng
    for p_=1:115
        if p_~=p
        for j=1:nf        
        c=c+1;
        xi(c,:)=reshape(X(p,:,i),N,1,1)';
        xj(c,:)=reshape(X(p_,:,j),N,1,1)';
        y(c,:)=-1;
        end
        end
    end
end

%% Test
xis= (ng*(27-ng)) + 45*ng;
xi_t=zeros(xis,N); xj_t=zeros(xis,N); y_t=zeros(xis,1);
c=0;
% Genuine
for j=ng+1:27
    for i=1:ng
        c=c+1;
        xi_t(c,:)=reshape(X(p,:,i),N,1,1)';
        xj_t(c,:)=reshape(X(p,:,j),N,1,1)';
        y_t(c,:)=1;
    end
end
% Skilled Forgery
for j=28:72
    for i=1:ng
        c=c+1;
        xi_t(c,:)=reshape(X(p,:,i),N,1,1)';
        xj_t(c,:)=reshape(X(p,:,j),N,1,1)';
        y_t(c,:)=-1;
    end
end


end

