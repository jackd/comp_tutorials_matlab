function compare(f_fn, dfdx_fn, x)
% COMPARE compares finite difference approximations.
%   f_fn: function handle
%   dfdx_fn: function handle representing the derivative of f
%   x: position to approximate derivative.

  % We use an exponential scale for h values.
  % When plotting on a log-scale, this results in points that appear equidistant
  h = 10.^linspace(-4, 0, 41);
  % Calculate derivative values
  forward = forward_difference(f_fn, x, h);
  backward = forward_difference(f_fn, x, -h);
  central = central_difference(f_fn, x, h);
  actual = dfdx_fn(x);

  % Calculate errors
  forward_err = abs(forward - actual);
  backward_err = abs(backward - actual);
  central_err = abs(central - actual);

  % Plot the results
  % plot h on the x axis, forward_err on the y-axis on a log-scale for both
  % 'b' argument makes the line blue.
  loglog(h, forward_err, 'b');
  % Put subsequent plots on the same figure
  hold on
  % 'k' argument makes the line black
  loglog(h, backward_err, 'k');
  % 'r' makes the line red.
  loglog(h, central_err, 'r');
  % Place a legend with labels 'forward', 'backward' and 'central' in SE corner
  % label order should correspond to the order in which the plots are added.
  legend('forward', 'backward', 'central', 'Location', 'southeast')
end
