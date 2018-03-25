function [ q ] = myModularity( g,comN,comK )


K = length(comK);

N = length(comN);
tempg = g;
for i=1:N
    if(~iscell(comN{i}))
        continue;
    end
    l = length(comN{i});
    if(l>1)
        tempg(i,:) = tempg(i,:)/repmat(l,1,N);
    end
end

adj = tempg;
% m
Avv = sum(sum(adj));

q = 0;
for k = 1:K
    c = comK{k};
    if isempty(c), continue; end
    % sum of group adj
    Avcvc = sum(sum(adj(c,c)));
    % deg
    Avcv = sum(sum(adj(c,:)));
    q = q + (Avcvc/Avv - (Avcv/Avv)^2);
end


end

