function [ x ] = REC( I,Size1,Hashiye )
J=I(:,:,1);
I=im2bw(I,.9); %UTSIG
[ I ] = Connected( I );
J(I==0)=0;
[ x1, x2, y1, y2 ] = FindEdges( I );
J=J(x1:x2,y1:y2);  
J=imresize(J,1/(max(size(J))/Size1));   
% J=imresize(J,[Size1 Size1]);
JJ=255*ones(size(J,1)+Hashiye,size(J,2)+Hashiye);
JJ=uint8(JJ);
JJ(Hashiye/2:end-Hashiye/2 - 1 ,Hashiye/2:end-Hashiye/2 - 1 )=J;

J=JJ;
J=im2bw(J,.9);


d=5;
n=4*d-4;
N=linspace(0,360,n+1); N=N(2:end);

Rec=ones(d,d);
Rec(2:end-1,2:end-1)=zeros(d-2,d-2);
ind=find(Rec);
c=0;
for i=1:length(ind);    
    Rec(ind(i))=N(i);
end

[X Y]=meshgrid(-floor(d/2):floor(d/2));



x=not(J);
l=find(x);
L=length(find(x));
l_=randperm(L,max(0,L-2000));
x(l(l_))=0;

% imshow(x);
% drawnow;

L=length(find(x));
[X_ Y_]=ind2sub([size(x,1) size(x,2)],find(x));

% x_=x(Hashiye/2:end-Hashiye/2 - 1 ,Hashiye/2:end-Hashiye/2 - 1 );

x_=ones(size(x,1),size(x,2));
[X_t Y_t]=ind2sub([size(x,1) size(x,2)],find(x_));
X_t=reshape(X_t,size(x,1),size(x,2));
Y_t=reshape(Y_t,size(x,1),size(x,2));
X_t=X_t(Hashiye/2:end-Hashiye/2 - 1 ,Hashiye/2:end-Hashiye/2 - 1 );
Y_t=Y_t(Hashiye/2:end-Hashiye/2 - 1 ,Hashiye/2:end-Hashiye/2 - 1 );
NWindow=2;
WindowSizeX=floor(size(X_t,1)/NWindow);
WindowSizeY=floor(size(Y_t,2)/NWindow);    
T=0;
x_SAVE=[];

for i1=1:NWindow
for j1=1:NWindow
    T=0;
    X_t_=X_t(1+(WindowSizeX*(i1-1)):(WindowSizeX*i1),1+(WindowSizeY*(j1-1)):(WindowSizeY*j1));
    Y_t_=Y_t(1+(WindowSizeX*(i1-1)):(WindowSizeX*i1),1+(WindowSizeY*(j1-1)):(WindowSizeY*j1));
    X_t_=X_t_(:);
    Y_t_=Y_t_(:);
    
    
    for i=1:L    
        if sign(sum(X_t_==X_(i)))*sign(sum(Y_t_==Y_(i)))==1
            for j=1:length(ind)
            T(i,j)=x(X_(i)+Y(ind(j)),Y_(i)+X(ind(j))).*Rec(ind(j));                 
            end
        end
    end
    
    T=T(T>0);
    [a b]=hist(T(:),Rec(ind));  
    x_save=a(n/2 +1:end);
    x_save=x_save(:)';
    x_SAVE=[x_SAVE x_save];
end
end


% for i=1:L    
%     for j=1:length(ind)
%         T(i,j)=x(X_(i)+Y(ind(j)),Y_(i)+X(ind(j))).*Rec(ind(j));                 
%     end
% end
% T=T(T>0);
% figure

% [a b]=hist(T(:),Rec(ind));
% x=a(n/2 +1:end);
x=x_SAVE;