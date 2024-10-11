## Compare local and global variables

i = 1
x = 0
for i in range(10):
    x += 1
print(i)
print(x)  # i and x updated by the loop


i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
a_function(10)
print(i)
print(x)  # i and x not updated

x = a_function(10)  # explicitly reassign the variable
x


## Variables before and after calling a function

_a_global = 10

if _a_global >= 5:
    _b_global = _a_global +5

print('Before calling a_function, outside the function, the value of _a_global is', _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    _a_global = 4  # local variable

    if _a_global >= 4:
        _b_global = _a_global +5  # local variable

    _a_local = 3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)
print("After calling a_function, outside the function, the value of _a_local is _a_local")
# _a_local not defined outside the function

## Compare the above with:
 
_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20  # the value is modified globally

    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()

    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)
