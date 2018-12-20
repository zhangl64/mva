% This is a numerical stable load-dependent MVA algorithm 
% with two tandem load-dependent queues. 
% Author: Lei Zhang
% Email: leizhang@ryerson.ca
% Please cite our publication (as shown in README.md) if you want to reuse
% this source code.

clear;

%input parameters should be N, Z, and D(i)
N = 100;
Z = 5;
%initialization
M = 2; %2-tiers
K = [8 8]; %2-tiers

% initialize service demands from N = 1 to N = 8.
D1 = [1/40 1/90 1/150 1/230 1/270 1/320 1/350 1/350];
D2 = [1/45 1/110 1/170 1/230 1/280 1/310 1/330 1/355];

% initialize service demands when N is larger than K(1)
if N > K(1)
    for i = (K(1)+1):N
        D1(i) = D1(K(1));
    end
end
% initialize service demands when N is larger than K(2)
if N > K(2)
    for i = (K(2)+1):N
        D2(i) = D2(K(2));
    end
end

qrD = zeros(M,N);
drD = zeros(M,N);

qrR = zeros(M,N);
drR = zeros(M,N);
Q = zeros(1,M);
normQ = zeros(1,M);

% initialize qrD and drD from M =1 to M =2.
for i=1:K(1)
    qrD(1,i) = D1(K(1));
    drD(1,i) = i*D1(i) - D1(K(1));
end
if N > K(1)
    for i=(K(1)+1):N
        qrD(1,i) = D1(K(1));
        drD(1,i) = (K(1) - 1) * D1(K(1));
    end
end

for i=1:K(2)
    qrD(2,i) = D2(K(2));
    drD(2,i) = i*D2(i) - D2(K(2));
end
if N > K(2)
    for i=(K(2)+1):N
        qrD(2,i) = D2(K(2));
        drD(2,i) = (K(2) - 1) * D2(K(2));
    end
end

%introduce N users one by one
for i = 1:N
    for j = 1:M
        qrR(j,i) = qrD(j,i) * (1 + Q(j)); %queueing resource
        if i == 1
            temp = 1;
        else
            temp = ceil( normQ(j)*i/(i-1) );
        end
        temp = int16(temp);
        drR(j,i) = drD(j,temp); %delay resource
    end
    X = i / ( Z + sum(qrR(:,i)) + sum(drR(:,i)) );
    for j = 1:M
        normQ(j) = X * ( qrR(j,i) + drR(j,i) );
        Q(j) = X * qrR(j,i);
    end
end

fprintf('Queue length per server is %f\n', Q);
fprintf('queue R=%f, and delay R=%f\n', sum(qrR(:,N)),sum(drR(:,N)));
fprintf('Total mean queue length is %f\n', sum(Q));
fprintf('---\nActual mean queue length is %f\n', sum(normQ));
fprintf('System throughput is %f\n', X);
fprintf('Mean response time is %f\n', 1000 * (sum(qrR(:,N)) + sum(drR(:,N))));
