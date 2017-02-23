function [n_passed, n_tests] = test_factorial()
% TEST_FACTORIAL function for testing factorial functions.
%  tests factorial_loop and factorial_recursive functionality.
%  RETURNS:
%    n_passed, n_tests
  addpath('../test');
  passed_loop = test_factorial_fn(@factorial_loop, 'factorial_loop');
  passed_recursive = test_factorial_fn(@factorial_recursive, ...
    'factorial_recursive');
  passed = [passed_loop, passed_recursive];

  [n_passed, n_tests] = summary(passed, 'factorial');
end

function passed = test_factorial_fn(f, f_name)
  passed = [];
  passed(end+1) = expect_throws(@() f(1.5), ...
    sprintf('throws on fraction, %s', f_name));
  passed(end+1) = expect_throws(@() f(-1), ...
    sprintf('throws on negative, %s', f_name));
  for n = [0, 1, 5, 8]
    passed(end+1) = expect_equal(f(n), factorial(n), ...
    sprintf('correct value for %d, %s', n, f_name));
  end
end
