# Finite Difference

## Theory
In this workshop we'll look at finite different approximations to derivatives. Recall the definition of the derivative,
```
df/dx = lim_{h -> 0} (f(x + h) - f(x)) / h
```

The forward finite different approximation is just the approximation for when `h` is small and positive,
```
df/dx f.d. approx = (f(x + h) - f(x)) / h, h > 0.
```

The backward difference approximation is similar, but can be thought of as the approximation when the second points is behind `x`,
```
df/dx b.d. approx = (f(x) - f(x - h)) / h, h > 0.
```

This is equivalent to using the forward different equation with a negative `h` value.

The final approximation we'll investigate here is called the central different approximation, which uses a point just to the left, and just to the right of the `x` value and averages the gradient,
```
df/dx c.d. approx = (f(x + h) - f(x - h)) / (2*h), h != 0.
```

Note this is the average of the forward and backward difference approximations,
```
c.d. approx = (f.d. approx + b.d. approx) / 2
```

## Matlab concepts
In this workshop we'll be looking at implementing the above approximations in matlab. In the process, we'll cover the concepts of function handles, vectorization and plotting.

Firstly, let's write a script to calculate the forward difference approximation of the derivative of `f(x) = x^2` about `x = 1` with `h = 0.1`. Create a new file `fd_err.m` and copy the following code in.
```
% Define parameters
x = 1;
h = 0.1;

% Simple error checking
if h == 0
  error('h cannot be zero')
end

% Calculate derivative values and error
dfdx_fd = ((x + h)^2 - x^2) / h;
dfdx_exact = 2*x
err = abs(dfdx_exact - dfdx_fd);

% Report approximate value and error
fd_approx
err
```

View the results by running `fd_err` from the command line. Experiment with different values of `x` (except `0`) and `h` (except `0`).

### Function handles
The above script is fine, and we could certainly convert it to a function such that it could take any value of `x` and `h`. However, the function `f(x) = x^2` and the derivative function `2*x` are still hard-coded. What we want is to create a variable that holds the function to be differentiated itself. We do that using function handles, or anonymous functions.

An anonymous function is a function without a name. We can create an anonymous function from the command line and assign it to a variable as follows:
```
>>> f = @(x) x^2;
```

We can now call `f` just like a function that has its own `f.m` file and associated code. It takes one parameter, and returns the value of that parameter squared.
```
>>> f(3)
ans = 9
>>> f(1.5)
ans = 2.250000
```

We can adjust the code in our script file above so that we can change the function and it's derivative in just one spot at the top of the file.
```
% Define parameters
f = @(x) x^2;
dfdx = @(x) 2*x
x = 1;
h = 0.1;

% Simple error checking
if h == 0
  error('h cannot be zero')
end

% Calculate derivative values and error
dfdx_fd = (f(x + h) - f(x)) / h;
dfdx_exact = dfdx(x)
err = abs(dfdx_exact - dfdx_fd);

% Report approximate value and error
fd_approx
err
```

We can now try this script with a variety of different functions and `x`/`h` values to compare the approximations with known derivatives. The only part we need to change each run is in the initial code block. Once we're satisfied the code runs as expected, we can easily refactor it into a function by replacing this initial code block with a function line (and associated documentation):
```
function err = fd_err(f, dfdx, x, h)
% FD_ERR evaluates the relative error of forward difference approximation.
%   f: function handle, maps R -> R
%   dfdx: function handle, maps R -> R, derivative of f
%   x: point to evaluate derivative/approximation
%   h: step size used in derivative, non-zero
```
and removing the report lines at the bottom to keep the output clean.

### Vectorization
The name `Matlab` comes from the combination of the words `Matrix Laboratory`. If you haven't come across matrices and vectors thus far, don't worry - for the moment, just consider them arrays of numbers. Vectors are 1D arrays - a list - and matrices are 2D, like a table.

The most common way of initializing matrices if using the `ones` or `zeros` inbuilt function,
```
>>> A = zeros(3, 4);
>>> A
ans =
   0   0   0   0
   0   0   0   0
   0   0   0   0
```

The inbuilt `linspace` function is for initializing vectors with linear spacing. It takes three arguments: a start value, end value and the number of length of the desired vector.
```
>>> l = linspace(0, 5, 6);
>>> l
ans =
  0   1   2   3   4   5
```

We can get the size of a matrix or vector using the `size` function,
```
>>> size(A)
ans =
  3   4
>>> size(A, 2)
ans = 4
>>> size(l)
ans =
  1  6
```
Note that our `linspace` vector is really just a matrix with first dimension 1.

We can set values using brackets,
```
>>> A(2, 3) = 1;
>>> A
A =
   0   0   0   0
   0   0   1   0
   0   0   0   0
```

We can access individual elements, or entire rows or columns
```
>>> A(2, 2)
ans = 0
>>> A(2, 3)
ans = 3
>>> A(2, :) % the second row
ans =
   0   0   1   0
>>> A(:, 3) % the third columns
ans =
   0
   1
   0
```

We can index vectors either as 1D or 2D arrays,
```
>>> l(2)
ans = 1
>> l(1, 3)
ans = 2
```

We can scale matrices and add two matrices of the same size them together,
```
>>> B = ones(3, 4)*2 + 3*A;
>>> B
ans =
   2   2   2   2
   2   2   5   2
   2   2   2   2
```

One thing we have to be careful about though is multiplication. Matrix multiplication is a special operation which is beyond the scope of this workshop. However, it isn't as simple as multiplying each of the elements like addition is. To do element-wise multiplication, we need to use the `.*` operator.
```
>>> A * B
error: operator *: nonconformant arguments (op1 is 3x4, op2 is 3x4)
>>> A .* B
ans =
   0   0   0   0
   0   0   5   0
   0   0   0   0
```

How can we use these facts effectively? Try the following:
```
>>> x = linspace(0, 10, 11)
ans =
    0    1    2    3    4    5    6    7    8    9   10
>>> f = @(x) x.^2;
>>> dfdx = @(x) 2*x;
>>> h = 0.1
>>> fd_err(f, dfdx, x, h)
ans =
Columns 1 through 7:
  0.100000   0.100000   0.100000   0.100000   0.100000   0.100000   0.100000
Columns 8 through 11:
  0.100000   0.100000   0.100000   0.100000
```
This is equivalent to writing a loop,
```
>>> for xi in x:
      fd_err(f, dfdx, xi, h)
    end
```
but will be executed much faster by matlab's internal optimization.

Try the above with `f(x) = @(x) x^2` and note the error.

Ordinarily, one cannot do element-wise operations on matrices of different sizes. The one exception to this is when one of the matrices dimensions is `1`, while the corresponding dimension of the other is not. For example, if we wanted to calculate the distance from the origin of each point on a `5` by `4` grid, we can use the following

```
>>> x = linspace(0, 4, 5);
>>> y = linspace(0, 5, 6)'; % the ' transposes the matrix, making it a columns
>>> dist = sqrt(x .* x + y .* y);
```

In this case `x .* x` will have size `(1, 5)`, and `y .* y` will have size `(6, 1)`. The result will have size `(6, 5)`.

### Exercises
1. Read the code in `forward_difference.m`, `central_difference.m` and `compare.m`. Make sure you understand it.
2. Experiment using different functions and their analytic derivatives. Which approximation method tends to give the best results for small `h`?
3. Read the documentation for `vis_fd`. Experiment with its usage using a variety of functions. Which finite difference approximation method gives the most accurate approximation most of the time? The code in this function is longer than most, but there shouldn't be anything you can't understand with a bit of digging.
4. Write vectorized code that allows you to calculate the derivative approximation for multiple `x` values and multiple `y` values using a single call to `forward_difference` or `central_difference`. The functions themselves need not be edited, but you'll have to be careful in constructing the arguments you pass into them.
