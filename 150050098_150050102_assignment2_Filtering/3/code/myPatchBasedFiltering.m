function out = myPatchBasedFiltering(imgPath, sigma)

    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors - 1):1]' , ... 
        [0:1/(myNumOfColors - 1):1]' , [0:1/(myNumOfColors - 1):1]' ]; 
    
    %%
    img = load(imgPath);
    img = img.imageOrig;
    
    % downsample by 2 
    img = img(1:2:end, 1:2:end);
    [m, n] = size(img);
    figure;
    imagesc(img);
    title('Original');
    colormap (myColorScale); 
    daspect ([1 1 1]);  
    axis tight;
    colorbar
    
    max_intensity = max(max(img));
    img = img / max_intensity;
    imgOrig = img;
    
    % corrupt image
    img = img + (0.05 * randn(m, n));
    figure;
    imagesc(img);
    title('Corrupted');
    colormap (myColorScale); 
    daspect ([1 1 1]);  
    axis tight;
    colorbar
    
    filtered_image = zeros(m, n);
    
    windowSize = 25;
    patchSize = 9;
    w = floor(windowSize / 2);
    p = floor(patchSize / 2);
    
    img = padarray(img, [p, p]);
    sigma_sq = sigma*sigma;
    
    h = waitbar(0, 'running patch based filtering..');
    step = 0;
    steps = m;
    for ii = 1:m
        for jj = 1:n
            t = max(1, ii - w + 1) + p;
            b = min(ii + w, m) + p;
            l = max(1, jj - w + 1) + p;
            r = min(jj + w, n) + p;
            
            centre = [ii+p, jj+p];
            centre_patch = img(centre(1)-p:centre(1)+p, centre(2)-p:centre(2)+p);
            centre_patch = centre_patch(:);
            
            weighted_av = 0;
            denom = 0;
            for kk = t:b
                for ll = l:r
                    patch = img(kk-p:kk+p, ll-p:ll+p);
                    no = norm(centre_patch - patch(:))^2;
                    correl = exp(-1.0 * no / sigma_sq);
                    denom = denom + correl;
                    weighted_av = weighted_av + correl * img(kk, ll);
                end
            end
            
            filtered_image(ii, jj) = weighted_av / denom;
        end
        step = step + 1;
        waitbar(step / steps);
    end
    close(h);
    
    rmsd = sqrt(sum(sum((imgOrig-filtered_image).^2)) / (m*n))
    
    figure;
    imagesc(filtered_image);
    title('Filtered');
    colormap (myColorScale);
    daspect ([1 1 1]);
    axis tight;
    colorbar
    
end