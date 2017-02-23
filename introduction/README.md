# Introduction to Matlab
Prerequesites: running installation of Matlab/octave

Open the Matlab IDE and navigate to this directory.

## Using Matlab from the command line

### Matlab as a calculator
While it's a bit of overkill, and doesn't nearly make best use of the tool, you can use matlab just as you would a calculator. Go to the command line and experiment with standard operators
```
>>> 2 + 3
ans = 5
>>> 3 / 4
ans = 0.7500000
>>> 2^3*4
ans = 32
```
In addition to standard algebraic operations, matlab has many inbuilt functions. We call these functions using `function_name(arg1, arg2, ..., argn)` syntax. Some examples are below.
```
>>> sin(pi/6)
ans = 0.5000000
>>> nchoosek(4, 2)
ans = 6
```
### Variable assignment
We can assign results to variables for later access.
```
>>> a = 3
a = 3
>>> b = 5
b = 5
>>> c = a + b
c = 8
```
The command line is starting to get a bit annoying - we generally don't need it echoing back everything we write. To suppress output, use a semicolon (`;`) at the end of each line.
```
>>> a = 3;
>>> b = 5;
>>> c = a + b;
>>> c
c = 8
```
### For loops
To repeat a process a predefined number of times, we use a for loop. For example, to add all the numbers from 1 to 5, we can use the following code:
```
>>> s = 0;
>>> for i = 1:5
      s = s + i;
    end
>>> s
```
Let's break this code down line by line.
```
>>> s = 0;
```
Initialize the value of the sum variable.
```
>>> for i = 1:5
```
This is the start of the loop. Everything between this and the corresponding `end` line will be run in sequence, with the value of `i` taking every value from `1` to `5` (including both `1` and `5`).
```
      s = s + i;
```
This is repeated for each value of `i` in the `for` line. Note if you forget the semicolon here, the result of each run through this line will be printed to screen. This can be handy for debugging purposes, but excessive use can clog your output, so unless you're looking for a problem in this section of code output suppression is the way to go.
```
    end
```
This signals the end of the for loop. Everything after this point runs just once, and the variable `i` takes the final value, in this case `5`. Note than none of the code inside the `for` loop will run until this line is entered.

We can generalize the above code to a variable upper limit `n`.
```
>>> n = 10;
>>> s = 0;
>>> for i = 1:n
      s = s + i;
    end
>>> s
```
### If tests
Sometimes you may want execution to split into one of two branches based on some condition. Continuing on from the above example, if the value of `n` was set somewhere further away, or was the result of a computation and you were unsure of its value, you might want to check to make sure it isn't negative.
```
>>> n = 10;
>>> if n < 0
      error('n must be non-negative')
    else
      s = 0;
      for i = 1:n
        s = s + i;
      end
      s
    end
```
This code will run identically to the block above. However, if you change the value of `n` in the first line to something negative, you'll notice very different output.

## Scripts
Copying and pasting (or worse, re-typing) the above code blocks into the command line each time you want to run something is awfully inefficient. Luckily, you can save chunks of code into text files with `.m` extensions and run the whole chunk with a single line. Create a new file named `my_first_script.m` in this directory and copy the last code block (without the `>>>`) into it. Save it.

From the command line, run
```
>>> my_first_script
```
If you want to calculate a different sum, change the first line, save, and rerun the script from the command line.

## Custom Functions
Of course, running the above script requires us to know the value of `n` before the code that computes the sum. To abstract this so that it can be run multiple times for different values of `n` without having to edit and save the script file, we need to write a function. Create a new file, `my_sum_function.m` and copy the following code.
```
function s = my_sum_function(n)
  % MY_SUM_FUNCTION computes the sum from 1 to n
  %  n: upper limit of sum, inclusive
  if n < 0
    error('n must be non-negative')
  end
  s = 0
  for i = 1:n
    s = s + i
  end
end
```
Let's break this down:
```
function s = my_sum_function(n)
```
This declares the function with name `my_sum_function` (must match the `.m` file name), argument `n` and the value returned to be whatever is in variable `s` at the end of function.
```
% MY_SUM_FUNCTION computes the sum from 1 to n
%  n: upper limit of sum, inclusive
```
Any line starting with a `%` is a comment, and ignored by the interpreter. These comments are for other developers, or yourself at a later time. They can also be viewed from the command line by using the `help` function
```
>>> help('my_sum_function')
MY_SUM_FUNCTION computes the sum from 1 to n
 n: upper limit of sum, inclusive
```

```
  if n < 0
    error('n must be non-negative')
  end
  s = 0
  for i = 1:n
    s = s + i
  end
```
This code should be looking familiar by now.

```
end
```
Just like ending a for-loop, we can (optionally) end a function. There is an implicit end for functions without this line, but it's a good habit to include an explicit one.

### Variable scoping
A key concept in programming is known as encapsulation. In short, it means one should write code that does its thing without making unintended changes to its environment - to be encapsulated from it. One way this is done is with variable scoping. The variables assigned inside the function are not accessible outside of the function itself. Similarly, any variable values assigned outside the function are inaccessible within it. The only way to pass variables in and out of a function is via the arguments passed in and the value returned.

While this may seem restrictive, it allows for the development of complex software while minimizing the risk of accidentally breaking anything. For example, if our `my_sum_function` could see and change the values of `s` and `i`, then any program using `my_sum_function` would have to be aware of that and be careful not to do anything with `s` and `i` that might be broken by this code.

Note: there is a way around the above: variables can be assigned as global for exactly this purpose, but there is almost always a better way than introducing global variables, since it breaks the principle of encapsulation.

## Factorials
The code in this directory contains two implementations equivalent to matlab's inbuilt `factorial` function: `factorial_loop`, and `factorial_recursive`. Look at the code for these functions and run the testing script `test_factorial` to verify everything works as expected. Don't worry too much about the code inside `test_factorial` - it is beyond the scope of this tutorial, though the output should be easily interpreted.

## Exercise: n choose k
The code in this directory contains two incomplete implementations designed to be equivalent to the `nchoosek` function: `nchoosek_factorial` and `nchoosek_recursive`. Complete these functions by replacing the relevant `error` lines with implementations using `factorial` function calls and `nchoosek_recursive` calls respectively. Test your implementations by calling the `test_nchoosek` function.

All tests can be run by running the `test_all` script,
```
>>> test_all
```
