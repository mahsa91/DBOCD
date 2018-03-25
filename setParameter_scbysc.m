function [ CO , K , Gnum_pre] = setParameter_scbysc(SW, cellW, T1, T2,Gnum_pre, A_b_pre, cal1,cal2, theta, alpha, myGamma)

%SW is a N*N which includes all nodes and edges over every time snapshot,
%   nodes that are not in a snapshot have no edges.
% Every snapshot should be symmetric

%cellW is N_t*N_t that includes adjacency matrix of graph in time t

%T1 number of iteration to find communities in the first snapshot
%T2 number of iteration to find communities in other snapshots

%CO is a cell of T time communities, CO{i} includes membership of N nodes

% Theta, alpha and gamma are DBOCD parameters (theta = [0.4 0.5 0.6], alpha = 0.1 and
%        gamma = 0.1*ones(N,1) are default values




% WORK WITH SW & cellW

if ~exist('alpha','var') || isempty(alpha)
  alpha=[];
end
% It is parameter with size N
if ~exist('myGamma','var') || isempty(myGamma)
  myGamma = [];
end

%myGamma(deg==0) = 0;
% overlapping fraction
if ~exist('theta','var') || isempty(theta)
  theta = []; 
end
if ~exist('cal1','var') || isempty(cal1)
  cal1 = fix(T1/2); 
end   

if ~exist('cal2','var') || isempty(cal2)
  cal2 = fix(T2/4); 
end  

% A_l = A little , A_b = A big , both of them are symmetric
A_b = SW;
A_l = cellW;
if ~exist('Gnum_pre','var') || isempty(Gnum_pre)
    [ allCO,allGnum] = DBOCD_fixNode(A_l,T1,[],theta, alpha, myGamma, cal1);
    [bestIndX,bestIndY,K(1)] = modularityEvaluation(A_l,allCO,cal1);
    Gnum_pre = allGnum{bestIndY};
    CO = allCO{bestIndX}{bestIndY};
else
    Gnum_new = preProcess_fixNode(A_b_pre,A_b,Gnum_pre);
  
    [ allCO,allGnum] = DBOCD_fixNode(A_l,T2,Gnum_new,theta, alpha, myGamma, cal2);

    [bestIndX,bestIndY,K] = modularityEvaluation( A_l,allCO,cal2);
    
    CO = allCO{bestIndX}{bestIndY}; 
    Gnum_pre = allGnum{bestIndY};  
end



end
