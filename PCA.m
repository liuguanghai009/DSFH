function features_pca = PCA(features,dim)
%%

 TF = isnan(features);
 
 features(TF) = 0;
 
%%

[~,score,~] = pca(features);

features_pca = score(:,1:dim);

end