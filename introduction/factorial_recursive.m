function p = factorial_recursive (n)
% FACTORIAL_RECURSIVE calculate n! = factorial(n) recursively.
%  n: must be non-negative integer.
  if floor(n) != n
    error('n must be an integer')
  end
  if n < 0
    error('n must be non-negative.')
  end
  if n == 0
    p = 1;
  else
    p = n*factorial_recursive(n-1);
   end
end
