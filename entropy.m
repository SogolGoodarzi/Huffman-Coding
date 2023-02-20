function Gk = entropy(transition_states,k)
    [V,D] = eig(transition_states');
    [~, index] = sort(diag(D));
    P = V(:,index(end));
    P = P/sum(P);
    for i=1:length(transition_states)
        for j=1:length(transition_states)
            Hi_(j) = transition_states(i,j)*log2(transition_states(i,j));
            H(i) = -sum(Hi_);
        end
        Hc_(i) = P(i).*H(i);
        H_(i) = P(i).*log2(P(i));
    end
    Hc = sum(Hc_);
    H_s1 = -sum(H_);
Gk = H_s1/k + Hc;
end
