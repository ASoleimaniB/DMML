function [ xi_t,xj_t,y_t ] = SkillForgOthers(X,p,ng,nf,ng_,nf_)
Total=115;
N=size(X,2); 
% GenP=((ng)*(ng-1)/2 )+ng 
% GenOthers=((ng_*(ng_-1)/2 )+ng_)*(Total-1)
% Skilled=0 ; %ng_*nf_*(Total-1)
% RandomforOne=(ng*nf*(Total-1))
% RandomforOthers=(ng_*nf_)*(((Total-2)*(Total-3)/2)+Total-2)
% xis= GenP + GenOthers + Skilled + RandomforOne  + RandomforOthers
% xi=zeros(xis,2); xj=xi; y=zeros(xis,1);
% c=0;
% %% Genuine
% for p_=1:Total
% %     p_
% if p_==p
%     for i=1:ng
%         for j=i:ng
%             c=c+1;
% %             xi(c,:)=reshape(X(p_,:,i),N,1,1)';
% %             xj(c,:)=reshape(X(p_,:,j),N,1,1)';
%             xi(c,:)=[p_ i];
%             xj(c,:)=[p_ j];
%             y(c,:)=1;
%         end
%     end
% else
%     for i=1:ng_
%         for j=i:ng_
%             c=c+1;
% %             xi(c,:)=reshape(X(p_,:,i),N,1,1)';
% %             xj(c,:)=reshape(X(p_,:,j),N,1,1)';
%             xi(c,:)=[p_ i];
%             xj(c,:)=[p_ j];
%             y(c,:)=1;
%         end
%     end
% end
% end
% 
% %% skilled Forgery
% % for p_=1:Total
% % %     p_;
% % if p_~=p
% % for i=1:ng_        
% %     for j=28:27+nf_
% %         c=c+1;
% % %         xi(c,:)=reshape(X(p_,:,i),N,1,1)';
% % %         xj(c,:)=reshape(X(p_,:,j),N,1,1)';
% %         xi(c,:)=[p_ i];
% %         xj(c,:)=[p_ j];
% %         y(c,:)=-1;
% %     end            
% % end
% % end
% % end
% 
% 
% %% Random Forgery just for p vs others
% for i=1:ng
%     for p_=1:Total
%         if p_~=p
%         for j=1:nf        
%         c=c+1;
% %         xi(c,:)=reshape(X(p,:,i),N,1,1)';
% %         xj(c,:)=reshape(X(p_,:,j),N,1,1)';
%         xi(c,:)=[p i];
%         xj(c,:)=[p_ j];
%         y(c,:)=-1;
%         end
%         end
%     end
% end
% % Random Forgery for Others
% for p_g=1:Total
% for p_=p_g+1:Total
%    if p_~=p && p_g~=p
%         for i=1:ng_   
%         for j=1:nf_        
%             c=c+1;
%             xi(c,:)=[p_g i];
%             xj(c,:)=[p_ j];
%             y(c,:)=-1;
%         end
%         end
%    end
% end
% end
%% Test
xis= (ng*(27-ng)) + 45*ng ;% + (Total-1)*(ng*72);
xi_t=zeros(xis,N); xj_t=xi_t; y_t=zeros(xis,1);
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

% Random Forgery
% for p_=1:Total
% if p_~=p
% for j=1:72
%     for i=1:ng
%         c=c+1;
%         xi_t(c,:)=reshape(X(p,:,i),N,1,1)';
%         xj_t(c,:)=reshape(X(p_,:,j),N,1,1)';
%         y_t(c,:)=-1;
%     end
% end
% end
% end

