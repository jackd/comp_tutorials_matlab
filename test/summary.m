function [n_passed, n_tests] = summary(passed, test_name)
% SUMMARY converts a boolean array of results to sum/total and possibly prints.
%  passed: boolean array of test results
%  test_name: (optional) name of test for disp purposes
  n_passed = sum(passed);
  n_tests = length(passed);
  if nargin == 2
    if n_tests == n_passed
      disp(sprintf('All %d %s tests passed!', n_tests, test_name));
    else
      disp(sprintf('%d / %d %s tests passed', n_passed, n_tests, test_name));
    end
  end
