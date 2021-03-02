% dataname="GHIM-10K��";

% dataname="Corel-10K��";

% dataname="Corel-1000��";

% dataname="Oxford_5K��";

% dataname="Oxford_105K��";

dataname="Paris_6K��";

% dataname="Holidays��";

%  dataname="UKB��";

filepatch="G:/��׼ͼ���/" + dataname + "/ͼ��/";

filename = dir(filepatch+"*.jpg");

[file_num, temp] = size(filename);

%%
net = vgg16;
insz = net.Layers(1).InputSize;
%%

cn1=6;
cn2=3;
cn3=3;

CSA = cn1*cn2*cn3;

CSB = 18;

Hcnum= CSA + CSB;

DSC = 128;

LowH = zeros(file_num,Hcnum);
HighH = zeros(file_num,DSC);
 %%
parfor i=1:file_num
  
    imdata = imread("G:/��׼ͼ���/" + dataname + "/ͼ��/" + filename(i).name);
   
    %%
    if size(imdata,3)==1
        rgb = cat(3,imdata,imdata,imdata);
        imdata = mat2gray(rgb);
    end
    
    %%
    img = single(imdata);
    
    %%
    [h,w,k] = size(img);
    
    %%
    if dataname=="Holidays��"
        img_resize = imresize(img, [586 586]);
        source = img_resize;%%It has been confirmed, please do not change
    end
    if dataname=="GHIM-10K��"||dataname=="Corel-10K��"||dataname=="Corel-1000��"
        if(h<384||w<384)
            img_resize = imresize(img, [384 384]);
        else
            img_resize = img;
        end
        source = imdata;%%It has been confirmed, please do not change
    end
    if dataname=="Oxford_5K��"||dataname=="Paris_6K��"||dataname=="UKB��"
        if(h<384||w<384)
            img_resize = imresize(img, [384 384]);
        else
            img_resize = img;
        end
        source = img_resize;%%It has been confirmed, please do not change
    end
    
    %%
    
    %%
    FC_NS = activations(net,img_resize,'fc7','OutputAs','channels');
    
    OSSH = OSSH_feature(source,cn1,cn2,cn3,CSB); %% input "source" rather than "img_resize"
    
    LowH(i,:) = OSSH;
    
    HighH(i,:) = FCLFH_feature(FC_NS,OSSH,DSC);
    
    %%����
    i
    %%
end

%%L2->PCAwhitening->L2

Low_feature = LowH;

FCLFH = normalize(HighH,2,'norm');

DSFH = whitening(FCLFH);

%%
for i=1:file_num
    
   %%
    
    split = strsplit(filename(i).name, {'.'});
    
    name = split(1);
    
    %%
    Low_feature_save = Low_feature(i,:)';
    save(['G:/VGG16����/',dataname{1},'/DSFH/�ͼ�����/',name{1},'.txt'],'Low_feature_save','-ASCII');
    
    %%
    
    FCLFH_save = FCLFH(i,:)';
    save(['G:/VGG16����/',dataname{1},'/DSFH/FCLFH����/',name{1},'.txt'],'FCLFH_save','-ASCII');
    
    %%
    
    DSFH_save = DSFH(i,:)';
    save(['G:/VGG16����/',dataname{1},'/DSFH/Rank����/',name{1},'.txt'],'DSFH_save','-ASCII'); 
    
    %%
    
    
end

