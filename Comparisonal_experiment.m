
dataname="Oxford_5K库";

% dataname="Paris_6K库";

filepatch="G:/标准图像库/" + dataname + "/图库/";

filename = dir(filepatch+"*.jpg");

[file_num, temp] = size(filename);

%%
net = vgg16;
insz = net.Layers(1).InputSize;
%%
FC7H = zeros(file_num,4096);

parfor i=1:file_num
    
    im = imread("G:/标准图像库/" + dataname + "/图库/" + filename(i).name);
    
    %%
    if size(im,3)==1
        rgb = cat(3,im,im,im);
        im = mat2gray(rgb);
    end
    
    img = single(im)
    
    [h,w,k] = size(img);
    
    img_resize = imresize(img, [224 224]);
    
    FC7H(i,:)= activations(net,img_resize,'fc7','OutputAs','channels');
    
    %%进度
    i
    %%
end

%%

dim=128;

features_pca = PCA(FC7H,dim);

features_pca_whiten = PCA_whitening(FC7H,dim);

for i=1:file_num
    
    % 获取图片序号d
    
    split = strsplit(filename(i).name, {'.'});
    
    name = split(1);
    %%
    
    feature_save = features_pca(i,:)';
    save(['G:/VGG16特征/',dataname{1},'/DSFH/FC7_PCA特征/',name{1},'.txt'],'feature_save','-ASCII');
    
    %%
    features_pca_whiten_save = features_pca_whiten(i,:)';
    save(['G:/VGG16特征/',dataname{1},'/DSFH/FC7_PCA白化特征/',name{1},'.txt'],'features_pca_whiten_save','-ASCII');
    
    %%
    
end
