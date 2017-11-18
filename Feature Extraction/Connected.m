function [ I ] = Connected( I )
        
        CC = bwconncomp(not(I));
        I=I*0;
        numPixels = cellfun(@numel,CC.PixelIdxList);
        for i=1:size(numPixels,2)
            [biggest,idx] = max(numPixels); 
            if biggest<100
                break
            end
            I(CC.PixelIdxList{idx}) = 1;
            numPixels(idx)=1;
            
        end
        I=not(I);


end

