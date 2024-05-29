function [label] = classify_from_PRNU(PCs, labels, img)
    
    img_g = im2double(im2gray(img)); 
    n = img_g - wiener2(img_g, [5 5]); % denoising / eliminazione contesto
    size_n = size(n);
    n = reshape(n, [1, size_n(1) * size_n(2)]);
    n_bar = mean(n, 'all');

    corrs = [];
    for i = 1:length(PCs)
        Pc = reshape(PCs{i}, [1, size_n(1) * size_n(2)]);
        Pc_bar = mean(Pc, 'all');
        correlation = dot(n - n_bar, Pc - Pc_bar) / ...
            (norm(n - n_bar, 2) * norm(Pc - Pc_bar, 2));
        corrs = [corrs, correlation];
    end
    
    [~, I] = max(corrs); % decisione
    label = labels(I);

end