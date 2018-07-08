
clc
clear all;

folder=fullfile('./lowshotImg_cropped5/');
folder_dirOutput=dir(fullfile(folder));
folderNames={folder_dirOutput.name}';

for i=3:length(folderNames)

    folder_dir = folderNames{i};
    file_dirOutput=dir(fullfile('./lowshotImg_cropped5/',folder_dir));
    fileNames={file_dirOutput.name}';
    
    for j=3:length(fileNames)
    
        file = fileNames{j};
        
        I = imread(strcat('./lowshotImg_cropped5/', folder_dir, '/', file));
        newim = imresize(I, 224 / max(size(I)), 'nearest');
        [r,c,d] = size(newim);  
        nPad = abs(c-r)/2;       
        padColor = [1 1 1];   
        padColor = reshape(padColor,1,1,3);  
        if c > r             
            newImage = cat(1,repmat(padColor,floor(nPad),c), newim, repmat(padColor,ceil(nPad),c));     %# Bottom padding
            imwrite(newImage, strcat('./lowshotImg_cropped5/', folder_dir, '/', file));
        elseif r > c             
            newImage = cat(2,repmat(padColor,r,floor(nPad)), newim, repmat(padColor,r,ceil(nPad)));     %# Right padding
            imwrite(newImage, strcat('./lowshotImg_cropped5/', folder_dir, '/', file));
        end
    end
end