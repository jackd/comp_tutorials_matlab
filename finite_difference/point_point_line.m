function f = point_point_line(x1, y1, x2, y2)
  % POINT_POINT_LINE get the function of the straight line from 2 points.
  %   x1: x value of first point
  %   y1: y value of first point
  %   x2: x value of second point
  %   y2: y value of second point
  % Returns:
  %   f: function of line
  if x1 == x2
    error('x values must be distinct');
  end
  % gradient
  gradient = (y2 - y1) ./ (x2 - x1);
  f = gradient_point_line(gradient, x1, y1);
end
