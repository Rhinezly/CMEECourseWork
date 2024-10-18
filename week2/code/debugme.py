def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y -1
            # import ipdb; ipdb.set_trace()
            # the line adds a breakpoint at where you want to pause and start a debugging session
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; {x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }; {z = };")
    return z

buggyfunc(20)
