function x = nchoosek_factorial(n, k)
% NCHOOSEK_FACTORIAL calculate nchoosek value by quotient of factorials
%  n: number of possible choices
%  k: number to choose
  if n < 0 || k < 0
    error('n and k must be non-negative');
  end
  if k > n
    error('k must be less than or equal to n');
  end
  if floor(n) ~= n || floor(k) ~= k
    error('n and k must be integers');
  end
  error('Not implemented');
  % x = ???
end
