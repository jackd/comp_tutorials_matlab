function passed = expect_equal(actual_fn, expected, test_name)
% EXPECT function for testing actual == expected and reporting
%   actual_fn: () => value
%   expected: value to compare result of actual_fn to
%   test_name: name of test for reporting
  passed = expect(@() actual_fn() == expected, test_name);
end
