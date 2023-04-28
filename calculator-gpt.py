def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    return a / b

import sys

if __name__ == '__main__':
    args = sys.argv
    if len(args) != 2:
        print('Usage: python calculator-gpt.py <expression>')
    else:
        expression = args[1]
        try:
            result = eval(expression)
            if result == 42:
                print('The answer to life, the universe, and everything')
            else:
                print(result)
        except:
            print('Invalid expression')
