function [ CoMx,CoMy ] = CoM( I )
% Center of Mass (GrayScale)

% I=double(I(:,:,1));
[Y X]=size(I);
[x y]=meshgrid(1:X,1:Y);
% I=255-I;
% I=I; %for binary
sJ=sum(sum(I));
CoMx=sum(sum(I.*x))/sJ;
CoMy=sum(sum(I.*y))/sJ;

end