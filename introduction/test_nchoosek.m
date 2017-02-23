function [n_passed, n_tests] = test_nchoosek()
% TEST_FACTORIAL function for testing factorial functions.
%  tests factorial_loop and factorial_recursive functionality.
%  RETURNS:
%    n_passed, n_tests
  addpath('../test')

  passed_factorial = test_nchoosek_function(@nchoosek_factorial, 'factorial');
  passed_recursive = test_nchoosek_function(@nchoosek_recursive, 'recursive');
  passed = [passed_factorial, passed_recursive];

  [n_passed, n_tests] = summary(passed, 'nchoosek');
end

function passed = test_nchoosek_function(f, f_name)
  passed = [];
  passed(end+1) = expect_throws(@() f(-1, 0), ...
    sprintf('negative n throws, %s', f_name));
  passed(end+1) = expect_throws(@() f(3, -1), ...
    sprintf('negative k throws, %s', f_name));
  values = [2, 1; 3, 3; 3, 0; 5, 4; 5, 1; 5, 2];
  for i = 1:size(values, 1)
    n = values(i, 1);
    k = values(i, 2);
    passed(end+1) = expect_equal(@() f(n, k), nchoosek(n, k), ...
      sprintf('correct value, (%d, %d), %s', n, k, f_name));
  end
end
