Table of contents
- [1. Python introduction](#1-python-introduction)
- [2. Fundamental python:](#2-fundamental-python-)
  * [2.1 Data Types:](#21-data-types-)
  * [2.2 Operators:](#22-operators-)
  * [2.3 Control Flow:](#23-control-flow-)
    + [2.3.1 if-else stattment:](#231-if-else-stattment-)
    + [2.3.2 while loop:](#232-while-loop-)
    + [2.3.3 for loops](#233-for-loops)
  * [2.4 Functions:](#24-functions-)
  * [2.5 Modules:](#25-modules-)
  * [2.6 Packages:](#26-packages-)

Acknowledgement: Me and ChatGPT

# 1. Python introduction
Python is a common programming language that frequently use to solve the problem in bioinformatics field. Here are some key topics you should consider when studying Python:

1. Syntax: Learn the basic structure and syntax of the language, including variables, data types, control structures, functions, and modules.

Object-Oriented Programming: Understanding the principles of object-oriented programming (OOP) is important in Python. Study classes, objects, inheritance, and polymorphism.

2. Standard Library: Get familiar with the Python Standard Library, which includes a large number of modules that provide useful functionality for tasks such as data processing, file handling, and web development.

3. Third-party Libraries: Learn how to install and use popular third-party libraries such as NumPy, Pandas, and Matplotlib for scientific computing, data analysis, and visualization.

4. Debugging and Error Handling: Practice debugging your code and learn how to handle exceptions and errors in a robust way.

5. Algorithms and Data Structures: Study common algorithms and data structures, such as sorting, searching, and graph algorithms, and how to implement them in Python.

6. Best Practices: Learn about best practices in coding, such as using functions and modules to organize code, writing documentation, and using version control systems.

7. Additionally, you can find many online tutorials and resources to help you along the way. It's important to practice coding and solve real-world problems to gain hands-on experience with the language.

# 2. Fundamental python:
## 2.1 Variables: 
Variables are containers that store values. In Python, you don't need to declare the type of a variable, and you can assign values to variables using the equal (=) sign. For example: x = 5
```
# Assigning values to variables
name = "Alice"
age = 30
is_student = False

# Using variables in expressions
print("My name is", name)
print("I am", age, "years old")

# Reassigning values to variables
name = "Bob"
age = 40
is_student = True

# Using updated values of variables
print("My name is", name)
print("I am", age, "years old")
print("Is Bob a student?", is_student)
```
## 2.2 Data Types: 
Python has several built-in data types, including integers (int), floating-point numbers (float), strings (str), and lists (list).
```
# Integer
age = 30

# Float
weight = 68.5

# String
name = "Alice"

# Boolean
is_student = False

# List
grades = [95, 80, 75, 92]

# Tuple
person = (name, age, weight)

# Dictionary
student = {
    "name": "Bob",
    "age": 25,
    "weight": 72.3
}

# Print data type of each variable
print(type(age))
print(type(weight))
print(type(name))
print(type(is_student))
print(type(grades))
print(type(person))
print(type(student))
```
This example demonstrates the different data types available in Python, including integers, floating-point numbers, strings, booleans, lists, tuples, and dictionaries. The type() function is used to determine the data type of each variable

## 2.3 Operators: 
Python supports various arithmetic, comparison, and assignment operators that can be used to perform operations on variables.
ex: +,-,*,/,%
```
# Arithmetic operators
a = 5
b = 2
print("a + b =", a + b)
print("a - b =", a - b)
print("a * b =", a * b)
print("a / b =", a / b)
print("a % b =", a % b)
print("a // b =", a // b)
print("a ** b =", a ** b)

# Comparison operators
c = 8
print("a == c:", a == c)
print("a != c:", a != c)
print("a < c:", a < c)
print("a > c:", a > c)
print("a <= c:", a <= c)
print("a >= c:", a >= c)

# Logical operators
x = True
y = False
print("x and y:", x and y)
print("x or y:", x or y)
print("not x:", not x)

```
## 2.4 Control Flow: 
Python has control flow statements such as if-else statements, for loops, and while loops, which allow you to control the flow of your program based on certain conditions.
```
# If-Else statement
score = 75

if score >= 90:
    print("Grade: A")
elif score >= 80:
    print("Grade: B")
elif score >= 70:
    print("Grade: C")
else:
    print("Grade: D")

# For loop
numbers = [10, 20, 30, 40, 50]

for number in numbers:
    print(number)

# While loop
counter = 1

while counter <= 5:
    print(counter)
    counter += 1

```
  
## 2.5 Functions: 
Functions are blocks of code that can be reused throughout your program. In Python, you can define your own functions using the def keyword.

```
# Define a function
def greeting(name):
    return "Hello, " + name + "!"

# Call the function
print(greeting("Alice"))

# Function with multiple parameters
def add(a, b):
    return a + b

print(add(5, 2))

# Function with default parameter value
def power(base, exponent=2):
    return base ** exponent

print(power(3))
print(power(3, 3))

# Function with variable-length arguments
def average(*args):
    sum = 0
    for arg in args:
        sum += arg
    return sum / len(args)

print(average(1, 2, 3, 4, 5))
```

## 2.6 Modules: 
Modules are collections of related functions and variables. You can use modules to organize your code and reuse code across multiple projects.
```
# Save the following code in a file called my_module.py
def greeting(name):
    return "Hello, " + name + "!"

def add(a, b):
    return a + b

# Use the module in another Python file or in the same file
import my_module

print(my_module.greeting("Alice"))
print(my_module.add(5, 2))

# Or you can import specific functions from a module
from my_module import greeting, add

print(greeting("Bob"))
print(add(3, 4))

# You can also give the imported functions a different name
from my_module import greeting as say_hello

print(say_hello("Charlie"))
  
```
## 2.7 Packages: 
Packages are collections of related modules. You can install and use packages from the Python Package Index (PyPI) to extend the functionality of your program. There are multiple modules in packages, need to download and then 
Require to install from sources
```
# Create a directory called my_package
# Inside the directory, create an __init__.py file
# Create a module in the directory called my_module.py
def greeting(name):
    return "Hello, " + name + "!"

# Use the package in another Python file or in the same file
import my_package.my_module

print(my_package.my_module.greeting("Alice"))

# Or you can import specific functions from a module
from my_package.my_module import greeting

print(greeting("Bob"))
```
Installing and using packages in Python is relatively simple. Here are the steps to install and use a package in Python:

Make sure you have Python installed on your computer.
Open a terminal or command prompt.
Use the pip package manager to install the package. The command is pip install <package_name>, where <package_name> is the name of the package you want to install. For example, to install the numpy package, you would run pip install numpy.
Once the installation is complete, you can import the package into your Python code using the import statement. For example, to use the numpy package, you would run import numpy as np.
You can now use the functions and classes defined in the package. For example, to create an array using numpy, you would run np.array([1, 2, 3]).
That's all there is to it! Just make sure to check the documentation of the package you're installing to see if there are any additional steps required to use it in your code.      
