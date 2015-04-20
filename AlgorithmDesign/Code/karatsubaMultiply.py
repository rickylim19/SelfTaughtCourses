#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

def num_digits(z):
    return len(str(z))

def bidigits(z, n):
    base_shift = 10**(n/2)
    first_digit = z / (base_shift)
    second_digit= z - (first_digit * base_shift)
    return (first_digit, second_digit)

def recur_multiply(x,y):
    if x == 0: return 0
    if x == 1: return y
    return y + recur_multiply(x-1, y)

def karatsuba(x, y):

    x,y = int(x), int(y)
    n = (num_digits(x) == num_digits(y)) and num_digits(x)

    if n:
        a, b = bidigits(x, n)
        c, d = bidigits(y, n)

        step_1 = recur_multiply(a, c)
        step_2 = recur_multiply(b, d)
        step_3 = (a + b) * (c + d)
        step_4  = step_3 - step_1 - step_2
        if n % 2 == 0 :
            result = 10**(n)*step_1 + 10**(n/2)*(step_4) + step_2
        else: 
            result = 10**(n-1)*step_1 + 10**(n/2)*(step_4) + step_2

        return result

if __name__ == '__main__':
    print(karatsuba(sys.argv[1], sys.argv[2]))
