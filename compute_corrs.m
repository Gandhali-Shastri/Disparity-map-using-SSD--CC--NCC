
function [dispMap] = compute_corrs(leftImage,rightImage,method)

leftImage=rgb2gray(leftImage);
rightImage=rgb2gray(rightImage);

[nrLeft,ncLeft] = size(leftImage);
% [nrRight,ncRight] = size(rightImage);

leftImage=im2double(leftImage);
rightImage=im2double(rightImage);

corrWindowSize = 21; %17 19
 
dispMap=zeros(nrLeft, ncLeft);
win=(corrWindowSize-1)/2;

maximize = 0;
if strcmp(method,'NCC') || strcmp(method,'CC')
    maximize = 1;
end
dMin = 0; 
dMax = 135; 

tic; 
for i=1+win:1:nrLeft-win
    % For every row in Left Image
    for j=1+win:1:ncLeft-win-dMax
        % For every column in Left Image
        % correlation score
        if(maximize)
            prevcorrScore = 0.0;
        else
            prevcorrScore = 65532;
        end
        % bestmatched
        % disparity score
        bestMatchSoFar = dMin;
        
        for d=dMin:dMax
           
            regionLeft=leftImage(i-win : i+win, j-win : j+win);
            
            regionRight=rightImage(i-win : i+win, j+d-win : j+d+ win);
            % local mean in left region
            meanLeft = mean2(regionLeft);
            %  local mean in right region
            meanRight = mean2(regionRight);          
            tempCorrScore = zeros(size(regionLeft));
            % Calculate the correlation score
            if strcmp(method,'SSD')
                tempCorrScore = (regionLeft - regionRight).^2;
            elseif strcmp(method,'NCC')
                den = sqrt(sum(sum(regionLeft.^2))* ...
                           sum(sum(regionRight.^2)));
                tempCorrScore = regionLeft.*regionRight/den;
            elseif strcmp(method,'CC')
                
                den = sqrt(sum(sum((regionLeft - meanLeft).^2))* ...
                           sum(sum((regionRight - meanRight).^2)));
                tempCorrScore = (regionLeft - meanLeft).*(regionRight ...
                                                          - ...
                                                          meanRight)/den;
            end
     
            corrScore=sum(sum(tempCorrScore));
            if(maximize)
                if(corrScore>prevcorrScore)
                    prevcorrScore=corrScore;
                    bestMatchSoFar=d;
                end
            else
                if (prevcorrScore > corrScore)
                    prevcorrScore = corrScore;
                    bestMatchSoFar = d;
                end
            end
        end
        % final matched
        dispMap(i,j) = bestMatchSoFar;
    end
end

timeTaken=toc;
disp('Time taken'); disp(timeTaken);

end