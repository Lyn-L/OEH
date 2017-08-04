function X = normalize(X)
% Normalize all feature vectors to unit length
% X = double(X);
% n = size(X,1);  % the number of samples
% Xt = X';
% l = sqrt(sum(Xt.^2));  % the row vector length (L2 norm)
% Ni = sparse(1:n,1:n,l);
% Ni(Ni>0) = 1./Ni(Ni>0);
% X = (Xt*Ni)';

for i=1:size(X,1)
    if(norm(X(i,:))==0)
        
    else
        X(i,:) = X(i,:)./norm(X(i,:));
    end
end

end
