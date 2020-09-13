function err = rmse(yo,yp)

% err = rmse(yo,yp)
%
% yo  - observed data vector
% yp  - predicted data vector
% err - root mean square error
%
% Description: The script calculates the root mean square error
% (RMSE) between two vectors.
% -----------------------------------------------------
% B. Herrmann, Email: bherrmann@cbs.mpg.de, 2013-07-27

err = sqrt(sum((yo(:)-yp(:)).^2)/length(yo));
