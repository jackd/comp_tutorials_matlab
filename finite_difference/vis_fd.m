function vis_fd(f, x, h, fd_type, xmin, xmax, dfdx)
  % VID_FD visualize finite difference approximations of gradient.
  %   f: function
  %   x: point at which to consider gradient
  %   h: step size used in gradient (visualization is dull if too small)
  %   fd_dtype: one of 'f', 'b', 'c' for forward, backward, central
  %     respectively. Defaults to 'c'
  %   xmin: min x-value. Defaults to x - 3h
  %   xmax: max x-value. Defaults to x + 3h
  %   dfdx: analytical derivative. If not provided, uses central difference
  %     approximation with very small h.
  % Example usages:
  %   >>> vis_fd(@(x) x.^2, 1, 0.5, 'c', 0, 2, @(x)2*x)
  %   >>> vis_fd(@(x) x.^2, 1, 0.5)

  % Set default args if not supplied. nargin is the number of arguments passed
  if nargin < 7
    dfdx = @(x) central_difference(f, x, sqrt(eps));
    if nargin < 6
      xmax = x + 3*h;
      if nargin < 5
        xmin = x - 3*h;
        if nargin < 4
          fd_type = 'c';
        end
      end
    end
  end

  if h == 0
    error('h cannot be zero')
  end

  % Find the x values of the two points of interest.
  if fd_type == 'c'
    x1 = x - h;
    x2 = x + h;
  elseif fd_type == 'f'
    x1 = x;
    x2 = x + h;
  elseif fd_type == 'b'
    x1 = x - h;
    x2 = x;
  else
    error('fd_type must be c, f or b')
  end

  % calculate the equation of the line passing through the two points
  y1 = f(x1);
  y2 = f(x2);
  fd_line = point_point_line(x1, y1, x2, y2);

  % calculate the equation of the tangent line
  y = f(x);
  dfdx_line = gradient_point_line(dfdx(x), x, y);

  % Plot the results
  figure();
  hold on;
  % plot the function in black ('k')
  fplot(f, [xmin, xmax], 'k');
  % plot the derivative points with red crosses
  plot([x1, x2], [y1, y2], 'rx');
  % plot the point at which everything is centered with a blue circle
  plot([x], [y], 'bo')
  % plot the straight derivative in blue
  plot([xmin, xmax], fd_line([xmin, xmax]), 'b');
  % plot the tangent line in green
  plot([xmin, xmax], dfdx_line([xmin, xmax]), 'g')
  legend('function', 'fd points', '(x, f(x))', 'finite difference', 'tangent');
  hold off;
end
