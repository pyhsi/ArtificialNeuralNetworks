function mse = CalcPCAReconError(x, q)
% CalcPCAReconError  Do a Principle Component Analysis on a data set x
%   [E,z] = CalcPCAReconError(x,q) with x a dataset with each column a data entry, 
%   performs PCA with result z and matrix E.
%   q is the reduced dimension (dimension of z)
%
%   See also PCA.

% get the dimension p of x and the number of datapoints N
p = size(x,1);
N = size(x,2);

% project
[E,z,d]=PCAJannes(x, q);

% now reconstruct and calculate the error
% reconstruct x
errorx = x; % for the shape
meanx = mean(x, 2);
stdx = std(x,0,2);
for i = 1:N
    errorx(:,i) = x(:,i) - ((E*z(:,i)).*stdx  + meanx);
end
%errorx = x - (E*z + repmat(mean(x, 2),1,N));

% calculate the distance
mse = sum(sum(errorx.^2))/N;