function avglen = average_length(chain,k)
    list1 = [];
    for i=1:length(chain)-k+1
        list1 = [list1 chain(i:k+i-1)];
    end
    list = reshape(list1,[k,length(chain)-k+1]);
    [C,ia,ic] = unique(list.','rows','stable');
    for i=1:length(ia)
        prob(i) = sum(ic == i)/size(list,2);
    end
    [dict,avglen] = huffmandict(cellstr(C),prob);
end

