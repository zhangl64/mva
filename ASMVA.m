% This is a numerical stable load-dependent MVA algorithm 
% Try to make a better estimate the value of i in D_d(i)
% Using Schweitzer's approximation
% Author: Lei Zhang
% Email: leizhang@ryerson.ca
% Please cite our publication (as shown in README.md) if you want to reuse
% this source code.

clear;

% initialization
N = 1000;
M = 2; %2-tiers
Z = 0;
K = 8; %2-tiers
epsilon = 0.01;

D = [1/40 1/90 1/150 1/230 1/270 1/320 1/350 1/350];
if N > K
    for i = (K+1):N
        D(i) = D(K);
    end
end

D_q = zeros(1, N);
D_d = zeros(1, N);
R_q = 0;
R_d = 0;
X = 0;

% initizalize the estimated Q
Q = zeros(1, M);
Q_e = zeros(1, M);
% revision 
Q_o = zeros(1, M);
for i =1:M
    Q_o(i) = N/(M+1);
end
Q_new = zeros(1, M);

% initialize D_q and D_d at CPU
for i=1:K
    D_q(i) = D(K);
    D_d(i) = i*D(i) - D(K);% - D(K)*D(K)/D(1);
end
if N > K
    for i=(K+1):N
        D_q(i) = D(K);
        D_d(i) = K*D(i) - D(K);
    end
end

fprintf('qrD(1)=%f, and drD(1)=%f\n',D_q(1),D_d(1));

% while loop the check the estimated Q
% while max( abs( rdivide( Q - Q_e, Q ) ) ) > epsilon
% revision - change Q to Q_o
while max(abs(Q_o - Q_e)) > epsilon || max(abs(Q - Q_new)) > epsilon
    for j = 1:M
        % initialize Q_e
        Q_e(j) = Q_o(j);
        Q(j) = Q_new(j);
        % response time
        R_q = D_q(N) * (1 + Q(j)*(N-1)/N ); %queueing resource
        temp = ceil(Q_e(j));
        temp = int16(temp);
        if temp > N
            fprintf('temp is %f\n', temp);
            R_d = D_d(N);
        else
            R_d = D_d( temp ); %delay resource
        end
    end
    % throughput
    X = N / (Z + R_q + R_d);
    % queue length
    for j = 1:M
        Q_new(j) = X * R_q;
        % revision
        Q_o(j) = X * ( R_q + R_d);
    end
end

fprintf('Queue length per server is %f\n',Q);
fprintf('R_queue=%f, and R_delay=%f\n',R_q,R_d);
fprintf('Total Queue length is %f\n',Q_o);
fprintf('System throughput is %f\n',X);
fprintf('Response time is %f\n',1000*(R_q+R_d));
        
