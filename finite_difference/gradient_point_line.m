function f = gradient_point_line(gradient, x1, y1)
  % GRADIENT_POINT_LINE get the equation of the line with given gradient/point.
  %   gradient: value of gradient
  %   x1: x value of point
  %   y1: y value of point
  % Returns:
  %   f: function for straight line.
  y_intercept = y1 - gradient*x1;
  f = @(x) gradient*x + y_intercept;
end
