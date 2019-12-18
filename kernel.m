function result = kernel(x,y,c,d)
result = (x' * y + c)^d;

%diff = x - y;
%result = exp(-1 * c * (diff.' * diff));