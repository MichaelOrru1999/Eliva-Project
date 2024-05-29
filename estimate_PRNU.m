function[prnu] = estimate_PRNU(imgs)

    size_img = size(imgs{1});
    prnu = im2double(zeros(size_img(1), size_img(2)));

    for i = 1:length(imgs)
        img = im2double(im2gray(imgs{i})); 
        denoised = wiener2(img, [5 5]); % denoising
        prnu = prnu + (img - denoised); % eliminazione contesto
    end

    prnu = prnu ./ length(imgs); % media
    
end