clc; clear; close all
tic
%% Address

% Genuine
addressGenuine='E:\ETC\Previous Projects & Course\Master\Data\UTSig all folders\SigResize\Genuine';
% Opposite hand Forgery
addressForgeryOH='E:\ETC\Previous Projects & Course\Master\Data\UTSig all folders\SigResize\Forgery\opposite hand';
% Simple Forgery
addressForgerySim='E:\ETC\Previous Projects & Course\Master\Data\UTSig all folders\SigResize\Forgery\simple';
% Skilled Forgery
addressForgerySki='E:\ETC\Previous Projects & Course\Master\Data\UTSig all folders\SigResize\Forgery\skilled';

%% Constant
nSigner=115;  %number of classes or individuals
nGenuine=27;    %number of genuine per class
nForgeryOH=3;   %number of opposite hand samples per class
nForgerySim=36; %number of simple forgeries per class
nForgerySkil=6; %number of skilled forgery
Size1=300;      % resize to this
NWindow=5;      % use NWindow-by-NWindow grid and then calculate gradients
Nbins=16;       % number of bins for gradienst

Address=[];
X=zeros(nSigner,Nbins*NWindow^2,nGenuine+nForgeryOH+nForgerySim+nForgerySkil);    

%% Load
for fol=1:nSigner
    %% Genuine
    FOLDER=addressGenuine;    
    FOLDEROpen=FOLDER;
    FOLDER=[FOLDER '\' num2str(fol) '\' '*.tif'];
    FOLDEROpen=[FOLDEROpen '\' num2str(fol) '\'];
    ImagesName = dir(FOLDER);
    L=nGenuine;

    for i1=1:L
        I=imread([FOLDEROpen ImagesName(i1).name]);
        

       [I X_]=PreProcess( I,Size1,Nbins,NWindow,NWindow );   
       X(fol,:,i1)=X_;

    end
    %% ForgeryOH
    FOLDER=addressForgeryOH;    
    FOLDEROpen=FOLDER;
    FOLDER=[FOLDER '\' num2str(fol) '\' '*.tif'];
    FOLDEROpen=[FOLDEROpen '\' num2str(fol) '\'];
    ImagesName = dir(FOLDER);
    L=nForgeryOH;

    for i2=1:L
        I=imread([FOLDEROpen ImagesName(i2).name]);
        [I X_]=PreProcess( I,Size1,Nbins,NWindow,NWindow );
        X(fol,:,i1+i2)=X_;

    end
    %% ForgerySim
    FOLDER=addressForgerySim;    
    FOLDEROpen=FOLDER;
    FOLDER=[FOLDER '\' num2str(fol) '\' '*.tif'];
    FOLDEROpen=[FOLDEROpen '\' num2str(fol) '\'];
    ImagesName = dir(FOLDER);
    L=nForgerySim;

%     display('forgery')
    for i3=1:L
        I=imread([FOLDEROpen ImagesName(i3).name]);        
        [I X_]=PreProcess( I,Size1,Nbins,NWindow,NWindow );
        X(fol,:,i1+i2+i3)=X_;

    end
    %% ForgerySki
    FOLDER=addressForgerySki;    
    FOLDEROpen=FOLDER;
    FOLDER=[FOLDER '\' num2str(fol) '\' '*.tif'];
    FOLDEROpen=[FOLDEROpen '\' num2str(fol) '\'];
    ImagesName = dir(FOLDER);
    L=nForgerySkil;

    for i4=1:L
        I=imread([FOLDEROpen ImagesName(i4).name]);
        [I X_]=PreProcess( I,Size1,Nbins,NWindow,NWindow );
        X(fol,:,i1+i2+i3+i4)=X_;

    end
    % code    
    display(num2str(fol));
% scatter(CoMx(:,fol),CoMx(:,fol));
end
toc