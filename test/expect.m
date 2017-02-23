function passed = expect(passed_fn, test_name)
% EXPECT function for testing passed_fn and reporting
%   passed_fn: () => bool indicating success/failure of test
%   test_name: name of test for reporting
  try
    passed = passed_fn();
  catch
    passed = false;
  end
  if passed
    disp(sprintf('PASSED %s', test_name));
  else
    disp(sprintf('FAILED %s', test_name));
  end
end
