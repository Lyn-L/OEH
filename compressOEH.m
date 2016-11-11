function [B] = compressOEH(X,R, eigVec, sample_mean)

% X = normalize1(X);
landmark = bsxfun(@minus, X, sample_mean);

landmark = landmark * eigVec;

% landmark = [landmark, ones(size(landmark,1),1)];



B = compactbit( landmark * R > 0);

end



