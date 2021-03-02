function  OSSH  = OSSH_feature(im,cn1,cn2,cn3,CSB)

CSA = cn1*cn2*cn3;

Dim = CSA + CSB;

[hei,wid,~] = size(im);

histogram = zeros(1,Dim);

OSSH = zeros(1,Dim);

% RGB to HSV

hsv = rgb2hsv(im);

colormap = cHSV(hsv, cn1,  cn2, cn3);

%%

orimap = EdgeOrientation(hsv(:,:,3), CSB);

%%
gaboresum = zeros(1,4);

gaboresum(1,1) = gabor_energy_special_compute(0, 2.3333);
gaboresum(1,2) = gabor_energy_special_compute(pi/4, 2.3333);
gaboresum(1,3) = gabor_energy_special_compute(pi/2, 2.3333);
gaboresum(1,4) = gabor_energy_special_compute(pi*3/4, 2.3333);

%%

gabor_energy = zeros(hei,wid,4);

gabor_energy(:,:,1) = gaborEnergy(hsv(:,:,3),0,2.3333);
gabor_energy(:,:,2) = gaborEnergy(hsv(:,:,3), pi/4, 2.3333);
gabor_energy(:,:,3) = gaborEnergy(hsv(:,:,3), pi/2, 2.3333);
gabor_energy(:,:,4) = gaborEnergy(hsv(:,:,3), pi*3/4,2.3333);

%% Representation of low-level features,namely OSSH

for h=2:hei-1
    for w=2:wid-1
        %%
        
        maxgabor = max(gabor_energy(h,w,1),max(gabor_energy(h,w,2),max(gabor_energy(h,w,3),gabor_energy(h,w,4))));
        
        %%color
        % 0 
        if colormap(h,w)==colormap(h,w-1) &&  colormap(h,w)==colormap(h,w+1)
            if maxgabor==gabor_energy(h,w,1)
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w)) + (1.0 + max(0,log(gaboresum(1,1))));
            else
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w)) +  maxgabor;
            end
        end
        % 45
        if colormap(h,w)==colormap(h-1,w+1) &&  colormap(h,w)==colormap(h+1,w-1)
            if maxgabor==gabor_energy(h,w,2)
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w))+(1.0 + max(0,log(gaboresum(1,2))));
            else
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w))+  maxgabor;
            end
        end
        % 90
        if colormap(h,w)==colormap(h-1,w) &&  colormap(h,w)==colormap(h+1,w)
            if maxgabor==gabor_energy(h,w,3)
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w)) + (1.0 + max(0,log(gaboresum(1,3))));
            else
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w)) +  maxgabor;
            end
        end
        % 135
        if colormap(h,w)==colormap(h-1,w-1) &&  colormap(h,w)==colormap(h+1,w+1)
            if maxgabor==gabor_energy(h,w,4)
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w))+ (1.0 + max(0,log(gaboresum(1,4))));
            else
                histogram(1,colormap(h,w)) = histogram(1,colormap(h,w)) +  maxgabor;
            end
        end
        
        % orientation
        % 0
        if orimap(h,w)==orimap(h,w-1) &&  orimap(h,w)==orimap(h,w+1)
            if maxgabor==gabor_energy(h,w,1)
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w))+(1.0 + max(0,log(gaboresum(1,1))));
            else
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w)) +  maxgabor;
            end
        end
        % 45
        if orimap(h,w)==orimap(h-1,w+1) &&  orimap(h,w)==orimap(h+1,w-1)
            if maxgabor==gabor_energy(h,w,2)
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w))+(1.0 + max(0,log(gaboresum(1,2))));
            else
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w)) +  maxgabor;
            end
        end
        % 90
        if orimap(h,w)==orimap(h-1,w) &&  orimap(h,w)==orimap(h+1,w)
            if maxgabor==gabor_energy(h,w,3)
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w))+(1.0 + max(0,log(gaboresum(1,3))));
            else
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w)) +  maxgabor;
            end
        end
        % 135
        if orimap(h,w)==orimap(h-1,w-1) &&  orimap(h,w)==orimap(h+1,w+1)
            if maxgabor==gabor_energy(h,w,4)
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w))+(1.0 + max(0,log(gaboresum(1,4))));
            else
                histogram(1,CSA+orimap(h,w)) = histogram(1,CSA+orimap(h,w)) +  maxgabor;
            end
        end
        %%
    end
end

%%

for j=1:Dim
    if log(histogram(j))>0
        OSSH(j) = max(1.0,log(histogram(j)))*max(1.0,log(histogram(j)));
    else
        OSSH(j) = 0;
    end
end

end

%%