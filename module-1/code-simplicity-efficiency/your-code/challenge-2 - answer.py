"""
The code below generates a given number of random strings that consists of numbers and 
lower case English letters. You can also define the range of the variable lengths of
the strings being generated.

The code is functional but has a lot of room for improvement. Use what you have learned
about simple and efficient code, refactor the code.
"""

import random

def Rdm_gen(a, b, n):
    x = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9']

    if a > b:
        return 'Incorrect min and max string lengths. Try again.'
    else:
        return [''.join(random.choices(x, k=random.randint(a,b))) for i in range(n)]
    
a = int(input('Enter minimum string length: '))
b = int(input('Enter maximum string length: '))
n = int(input('How many random strings to generate? '))

print(Rdm_gen(a, b, n))