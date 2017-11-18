function [ J,X ] = PreProcess( I,Size1,Nbins,NWindowx,NWindowy )
        J=I;
        I=im2bw(I,.9); %for UTSIG (a threshold for a temp. binarization before connected component analysis.
        [ I ] = Connected( I );
        J(I==0)=0;
        [ x1, x2, y1, y2 ] = FindEdges( I );
        J=J(x1:x2,y1:y2);     %           
        J=imresize(J,1/(max(size(J))/Size1)); % has _ when J=                

        J=255-J;
        h=fspecial('average',[2 2]);
        J=imfilter(J,h);
        J=double(J);        
        J(J<10)=0; %for UTSIG (a threshold to remove noise)
        J(J>0)=J(J>0)-(min(J(J>0))-1);
        J(J>0)=J(J>0)./(max(J(J>0)));
        J(J>0)=J(J>0)*(255-150);
        J(J>0)=J(J>0)+150;    
        J=uint8(J);

        
        [Gmag,Gdir] = imgradient(J,'Prewitt');

        
        X=[];
        WindowSizeX=floor(size(Gmag,1)/NWindowx);
        WindowSizeY=floor(size(Gmag,2)/NWindowy);
        for i=1:NWindowx
            for j=1:NWindowy
                Gmag_windows=Gmag(1+(WindowSizeX*(i-1)):(WindowSizeX*i),1+(WindowSizeY*(j-1)):(WindowSizeY*j));
                Gdir_windows=Gdir(1+(WindowSizeX*(i-1)):(WindowSizeX*i),1+(WindowSizeY*(j-1)):(WindowSizeY*j));
                [ x_ ] = HIST( Gmag_windows,Gdir_windows,Nbins );
                x__=sum(x_);
                if x__==0
                    x__=1;
                end
                
                X=[X;x_];
            end
        end
        
end

