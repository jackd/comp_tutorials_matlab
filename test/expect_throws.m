function passed = expect_throws(fn, test_name)
% VERIFY_THROWS  verify the given function handle throws.
%   fn: () => object, function handle to be executed.
  try
    fn()
    passed = expect(@() false, test_name);
  catch
    passed = expect(@() true, test_name);
  end
end
