function dfdx = central_difference(f, x, h)
  % CENTRAL_DIFFERENCE approximates the derivative.
  %   f: function to approximate the derivative
  %   x: point to approximate the derivative
  %   h: step size, non-zero
  if any(h == 0)
    error('h cannot be zero');
  end
  dfdx = (f(x + h) - f(x - h)) ./ (2*h);
end
