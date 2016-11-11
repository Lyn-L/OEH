function [W,SimMatrix] = ObtainAffinityMatrix(Diff)

Diff=(Diff+Diff')/2;
[T,INDEX]=sort(Diff,2);
W=zeros(size(Diff));
[m,n]=size(W);

%% Transfer from Distance to Affinity Matrix, Following our ECCV 2008 paper
K=17;
for i=1:m
    for j=1:n
        SIGMA=mean([T(i,2:K),T(j,2:K)]);
        W(i,j)=normpdf(Diff(i,j),0,0.35*SIGMA);%
    end
end


W=(W+W')/2;
SimMatrix = W.*(~eye(length(W)));