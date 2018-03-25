function [ comK ] = comNtoComK_new( comN )
N = length(comN);
comK = cell(1,1);
if(iscell(comN(1)))
    for i=1:N
        for j=1:length(comN{i})
            k = comN{i}(j);
            if(k>length(comK))
                comK{k} = [];
            end
            comK{k} = [comK{k} i];
        end
    end
else
    for i=1:N
        k = comN(i);
        if(k>length(comK))
            comK{k} = [];
        end
        comK{k} = [comK{k} i];
    end
end
comK = comK(~cellfun('isempty',comK));
for i=1:length(comK)
    comK{i} = unique(comK{i});
end
end


