function F = myFunc(X , Vt , r)
    Vtr(1:r , :) = Vt(1:r , :);
    F = X * transpose(Vtr);
end