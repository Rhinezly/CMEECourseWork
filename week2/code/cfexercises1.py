def foo_1(x):
    return x ** 0.5

foo_1(4)
foo_1(2)


def foo_2(x, y):
    if x > y:
        return x
    return y

foo_2(0, 5)
foo_2(3, 1)


def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

foo_3(1, 2, 3)
foo_3(3, 2, 1)
foo_3(3, 1, 2)
foo_3(1, 3, 2)


def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

foo_4(3)


def foo_5(x):  # recursice funtion that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x -1)

foo_5(4)


def foo_6(x):  # another way to calculate factorial
    facto = 1
    while x >=1:
        facto = facto * x
        x = x-1
    return facto

foo_6(4)