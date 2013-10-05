# Range Utils (for Dart) #

Range Utils provides the common use case for generating an iteratble 
of numbers in sequential order.

There are a few ways to use Range Utils.  

## A NOTE ABOUT THESE EXAMPLES ##

In the examples below, I use `.toList()` and `.take(...)` to force the Range iterable to 
fully compute.  In practice you should almost never use these functions while using anything 
from range utils.  Always just use the result of any range function or constructor without 
converting it to a list or something.

## Using the Range constructor ##

The most basic functionality comes from using the default Range constructor.

It takes as parameters a start and an end point, and optionally an increment and 
an inclusive modifier.  

    > new Range(5, 10).toList(); [5 to 10] exclusive
    [5,6,7,8,9]
    
    > new Range(-5, 5, 2, true).toList(); [-5 to 5] by 2 inclusive
    [-5, -3, -1, 1, 3, 5]
    
    > new Range(10, 5, -2).toList(); // [10 to 2] by -2 exclusive
    [10,8,6]
    
    > new Range(0, 10, 2, true).toList(); // [0 to 10] inclusive
    [0,2,4,6,8,10];
    
## Using the Range.infinite constructor ##

Creating infinite ranges can also be handy.  The Range.infinite constructor does 
this for you. 

It takes as optional parameters start and increment numbers. 

    > new Range.infinite().take(10).toList();
    [0,1,2,3,4,5,6,7,8,9]
    
    > new Range.infinite(5).take(10).toList();
    [5,6,7,8,9,10,11,12,13,14]
    
    > new Range.infinite(5, 2).take(5).toList();
    [5,7,9,11,13]
    
Providing a negative step will make it trend towards negative infinity.

    > new Range.infinite(0, -1).take(5).toList();
    [0,-1,-2,-3,-4]
    
## Using py_range() ##

Because the idea for range() came from python, py_range emulates the behavior of 
python's xrange() function.  

    > py_range(5).toList();
    [0,1,2,3,4]
    
    > py_range(5,10).toList();
    [5,6,7,8,9]
    
    >py_range(5, 20, 2).toList();
    [5,7,9,11,13,15,17,19]
    
## Using range() ##

The `range(...)` function is meant to be used with named optional parameters to 
make the purpose of the arguments more clear.

    > range(end: 5).toList();
    [0,1,2,3,4]
    
    > range(start: 5, end: 10).toList();
    [5,6,7,8,9]
    
    > range(start: 5, end: 10, step: 2).toList();
    [5,7,9]
    
    > range(start: 10, end: 20, step: 2, inc: true).toList();
    [10,12,14,16,18,20]