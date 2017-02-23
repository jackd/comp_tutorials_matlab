function x = nchoosek_recursive(n, k)
% NCHOOSEK_FACTORIAL calculate nchoosek value by quotient of factorials
%  n: number of possible choices
%  k: number to choose
  if n < 0 || k < 0
    error('n and k must be non-negative');
  elseif k > n
    error('k must be less than or equal to n');
  elseif floor(n) != n || floor(k) != k
    error('n and k must be integers');
  end

  if n == 0 || n == 1
    x = 1;
  elseif k == n || k == 0
    error('Not implemented');
    % x = ???;
  else
    error('Not implemented');
    % x = ???;
  end
end
