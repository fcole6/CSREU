
function f=f(v,D,xi,vinit,n)
%  function f=f(v,D,xi,vinit)
% extract variables and parameter from v
  u=v(1:end-1);a=v(end);
% build the function from vector field and the condition that variable, parameter together are orthogonal to kernel
  f=[D*u+u.*(1-u).*(u-0.5)+a*ones(n,1);(v-vinit)'*xi];
% define the derivative when using the Jacobian for the newton solver
end


