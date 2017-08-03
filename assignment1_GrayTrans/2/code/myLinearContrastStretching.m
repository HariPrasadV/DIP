function out = myLinearContrastStretching(img)
    % img -> image (any dimension)
    % out -> linearly contrast stretched img 
    
    [~, ~, d] = size(img);
    
    for ii = 1:d
        minIntensity = min(min(img(:,:,ii)));
        maxIntensity = max(max(img(:,:,ii)));
        out(:,:,ii) = (img(:,:,ii) - minIntensity) * (255 / (maxIntensity - minIntensity));
    end
