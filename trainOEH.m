function [W,pc,sampleMean] = trainOEH(traindata,param)

sampleMean = mean(traindata,1);
traindata = (double(traindata)-repmat(sampleMean,size(traindata,1),1));

% traindata = normalize1(traindata);

L = param.L; % landmark numbers
MaxIter = param.maxIter;
beta = param.beta; lamda = param.lamda;  alph = param.alph;
bits = param.nbits;
dimD = param.dimD;
k = param.k;
[~, landmark] = litekmeans(traindata, L, 'MaxIter', 50);

[pc, ~] = eigs(cov(traindata),dimD);

clear traindata;
Diff = EuDist2(landmark);
[~,SimMatrix] = ObtainAffinityMatrix(Diff); % construct the affinity matrix
iter = 0;

landmark = landmark * pc;

dim = size(landmark,2);
W = randn(dim,bits);
while(iter<MaxIter)
    cout = 0;
    rp1 = iter + 1;
    if mod(rp1,L) == 0
        rp1 = L;
    else
        rp1 = mod(rp1,L);
    end
    
    list = SimMatrix(rp1,:);
    
    [~,ind] = sort(list,'ascend');
    
    gradW = zeros(size(W));
    t_land = landmark(ind,:);
    H = tanh(landmark*W);
    k = 10;
    for i = 2:k
        for j = k:L
            Hxi = H(1,:); Hxj = H(i,:); Hxk = H(j,:);
            tmp1 = t_land(1,:)' * ((1-Hxi.^2) .* (Hxj)) + t_land(i,:)' * ((1-Hxj.^2) .* (Hxi));
            tmp2 = t_land(1,:)' * ((1-Hxi.^2) .* (Hxk)) + t_land(k,:)' * ((1-Hxk.^2) .* (Hxi));
            Tij = (Hxi) * (Hxj)';
            Tik = (Hxi) * (Hxk)';
            ytmp = 1 / (1+exp(-(beta+Tij - Tik)));
            y = (ytmp * (1-ytmp));
            if beta + Tij > Tik
                gradW = gradW + 0.5* y * (tmp1-tmp2);
                cout = cout + 1;
            end
        end
    end
    
    I = eye(size(W,1),size(W,1));
    Wt = (W*W'-I) * W;
    W = W - (alph)*((lamda) * Wt + (1/cout)* gradW);
    if mod(iter,10) == 0
        fprintf('iter %d \n', iter);
    end
    iter = iter + 1;
end
end