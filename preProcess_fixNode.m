function [ Gnum_new ] = preProcess_fixNode( A_b_pre,A_b, Gnum_pre )

%N_l_pre = length(A_l_pre);
%N_b = length(A_b);
%K_pre = size(beta_pre,2);
K_pre = max(Gnum_pre);
% Find Edge indexes
[X,Y] = ind2sub(size(A_b_pre),find(triu(A_b_pre>0)));

Gnum_mat = zeros(size(A_b_pre));
Gnum_mat(sub2ind(size(A_b_pre),X,Y)) = Gnum_pre;
mask1 = triu(A_b_pre) == 1 & triu(A_b) == 0;
mask2 = triu(A_b_pre) == 0 & triu(A_b) == 1;
Gnum_mat(mask1) = 0;
new_edge = sum(sum(mask2));
new_edge_rand = randi(K_pre,new_edge,1);
Gnum_mat(mask2) = new_edge_rand;

Gnum_new = Gnum_mat(Gnum_mat > 0);


end


