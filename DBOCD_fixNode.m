function [ allCO,allGnum] = DBOCD_fixNode( A,T,Gnum,theta,alpha,myGamma, cal )

N = length(A);
A  =triu(A);

[X,Y] = ind2sub(size(A),find(A>0));

M = length(X);


if ~exist('alpha','var') || isempty(alpha)
    alpha=0.1;
end
% It is parameter with size N
if ~exist('myGamma','var') || isempty(myGamma)
    myGamma = 0.1*ones(N,1);
end


% overlapping fraction
if ~exist('theta','var') || isempty(theta)
    theta = [0.4,0.5,0.6];
end

% M*K - true false

if ~exist('Gnum','var') || isempty(Gnum)
    K = fix(N/10);
    %    K = 100;
    Gnum = zeros(M,1);
    
    for i=1:M
        temp = randi(K);
        Gnum(i) = temp;
    end
else
    K = max(Gnum);
end
%Initialize mybeta with other algorithm
n_i_k = zeros(N,K);
n_k = zeros(1,K);


for j=1:M
    r = Gnum(j);
    n_i_k(X(j),r) = n_i_k(X(j),r) + 1;
    n_i_k(Y(j),r) = n_i_k(Y(j),r) + 1;
    n_k(r) = n_k(r) + 1;
end
mybeta = n_i_k./repmat(2*n_k,N,1);
mybeta(isnan(mybeta)) = 0;



sumGamma = sum(myGamma);

%allCO = cell(T,1);
allGnum = cell(cal,1);
allCO = cell(1,length(theta));


temporaryVal = log(alpha)+log(myGamma(X(1)))+log(myGamma(Y(1)))-log(sumGamma+1)-log(sumGamma);
disp('Sampling:')
for i=1:T
    fprintf('%d ',i);

    p = zeros(1,K+1);
    p(K+1) = exp(temporaryVal);
    %G(j,:) = false;

    change_K = 0;
    for j=1:M
        

        p = n_k.*mybeta(X(j),:).*mybeta(Y(j),:);
 
        ind = find(rand<cumsum(p)/sum(p),1);

        Gnum(j) = ind;
        
        if(ind == K+1)
            change_K = 1;
        end

    end
    %tic
    n_i_k = zeros(N,K);
    n_k = zeros(1,K);
    if(change_K)
        mybeta(:,K+1) = drchrnd(myGamma',1);
        n_k(1,K+1) = 0;
        n_i_k(:,K+1) = zeros(N,1);
        K = K + 1;
    end

    for j=1:M
        r = Gnum(j);
        n_i_k(X(j),r) = n_i_k(X(j),r) + 1;
        n_i_k(Y(j),r) = n_i_k(Y(j),r) + 1;
        n_k(r) = n_k(r) + 1;
    end

    % Sample mybeta
    % N*K every K is a column
    for k=1:K
        if(n_k(k)~=0)
            temp = (myGamma+n_i_k(:,k))';
            mybeta(:,k) = drchrnd(temp,1);
        end
    end

    % compute u for every node in every group
    if(i > T-cal)
        pi_k = n_k/M;
        u_k = repmat(pi_k,N,1).*mybeta;
        tempMaxVal = max(u_k');
        temp_u_k = u_k./repmat(tempMaxVal',1,K);
        for theta_iter=1:length(theta)
            CO = cell(N,1);
            [tempX,tempY]=ind2sub(size(temp_u_k),find(temp_u_k>=theta(theta_iter)));
            for n=1:length(tempX)
                x1 = tempX(n);
                y1 = tempY(n);
                CO{x1} = [CO{x1},y1];
            end
            allCO{theta_iter}{i - T + cal} = CO;
        end
        allGnum{i - T + cal} = Gnum;
    end
end

end

