% Part(1):
State = rand>=0.5;
prob = [0,8/13,5/13];
Sum = cumsum(prob);
chain = [];
for i=1:1e6
    logic = rand>Sum;
    if (logic(2)==0)
        next_State = 0;
        if (next_State == State)
            chain = [chain,'B'];
        else
            chain = [chain,'A'];
        end
    elseif (logic(2)==1)
        next_State = 1;
        if (next_State == State)
            chain = [chain,'B'];
        else
            chain = [chain,'A'];
        end
    end
end
TS = [0.5,0.5;0.8,0.2];
K = 1:10;
for k=1:10
    avglen(k) = average_length(chain,k);
    G(k) = entropy(TS,k);
    HX = 0.893;
    efficiency(k) = HX/avglen(k)*k;
end
figure(1);
plot(K,avglen,'b');
hold on
plot(K,G,'r');
legend("average length","G_k");
hold off
figure(2);
for i=1:10
    H_x(i) = 0.893;
end
plot(K,H_x,'b');
hold on
plot(K,efficiency,'r');
legend("entropy","efficiency");
hold off
figure(3);
plot(K,avglen,'b');
hold on
plot(K,G,'r');
plot(K,efficiency,'m');
plot(K,H_x,'g');
legend("average length","G_k","efficiency","entropy");
%% Part(2):
size = 1e3;
prob1 = [0.7,0.01,0.29];
alphabet1 = 1:3;
chain1 = randsrc(size,1,[alphabet1;prob1]);
prob2 = kron(prob1,prob1);
alphabet2 = 1:9;
chain2 = randsrc(size,1,[alphabet2;prob2]);
prob3 = kron(prob1,prob2);
alphabet3 = 1:27;
chain3 = randsrc(size,1,[alphabet3;prob3]);
for i=alphabet1
    TS1(i,alphabet1) = prob1; 
end
for i=alphabet2
    TS2(i,alphabet2) = prob2; 
end
for i=alphabet3
    TS3(i,alphabet3) = prob3; 
end
CHAIN = [chain1';chain2';chain3'];
Hx1 = -sum(prob1.*log2(prob1));
Hx2 = -sum(prob2.*log2(prob2));
Hx3 = -sum(prob3.*log2(prob3));
HX = [Hx1,Hx2,Hx3];
newChain = char(96+CHAIN);
for n=1:3
    for k=1:10
        averagelength(n,k) = average_length(newChain(n,:),k);
        Gk1(k) = entropy(TS1,k);
        Gk2(k) = entropy(TS2,k);
        Gk3(k) = entropy(TS3,k);
        Efficiency(n,k) = HX(n)/averagelength(n,k)*k;
    end
end
GKK = [Gk1;Gk2;Gk3];
figure(1);
K = 1:10;
plot(K,averagelength(1,:),'b');
hold on
plot(K,Gk1,'r');
plot(K,Efficiency(1,:),'m');
for i=1:10
    H_x1(i) = Hx1;
end
plot(K,H_x1,'g');
legend("average length","G_k","efficiency","entropy");
title("Parameters for X");
hold off

figure(2);
K = 1:10;
plot(K,averagelength(2,:),'b');
hold on
plot(K,Gk2,'r');
plot(K,Efficiency(2,:),'m');
for i=1:10
    H_x2(i) = Hx2;
end
plot(K,H_x2,'g');
legend("average length","G_k","efficiency","entropy");
title("Parameters for X^2");
hold off

figure(3);
K = 1:10;
plot(K,averagelength(3,:),'b');
hold on
plot(K,Gk3,'r');
plot(K,Efficiency(3,:),'m');
for i=1:10
    H_x3(i) = Hx3;
end
plot(K,H_x3,'g');
legend("average length","G_k","efficiency","entropy");
title("Parameters for X^3");
hold off



