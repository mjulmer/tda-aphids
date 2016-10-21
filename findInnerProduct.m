%takes two sets of order parameters and takes their inner product
%<f-g, f-g> = integral of (f-g)^2
function innerProduct = findInnerProduct(orderParams1, orderParams2)
    diff = abs(orderParams1 - orderParams2); %so this should now be an array of the same dimensions
    squared = diff.^2;
    innerProduct = sum(squared(:)); %remember to exclude the last endpoint!
end