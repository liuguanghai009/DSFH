function output = quantization(X, num)

%%
A = max(max(X));

B = min(min(X));

input = (X-A)./(B-A);

%%

sz = size(input);

output = zeros(sz);

for i = 1:sz(1)
    for j = 1:sz(2)
        
        output(i,j) = fix(input(i,j) * num);
        
        if output(i,j) > num
            output(i,j) = num;
        end
        
        if output(i,j) < 1 || isnan(output(i,j))
            output(i,j) = 1;
        end
        
    end
end

end