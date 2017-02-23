function p = factorial_loop (n)
% FACTORIAL_LOOP calculate n! = factorial(n) using a loop.
%  n: must be non-negative integer.
  if floor(n) != n
    error('n must be an integer')
  end
  if n < 0
    error('n must be non-negative.')
  end
  p = 1;
  for i = 2:n
    p = p * i;
  end
end
