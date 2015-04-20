#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys

class Crt(object):
    """
    return the smallest number(n) using Chinese Remainder Theory Algorithm
    given a list of remainder (rem) and a list of modulor (mod)

    Video explanation by Cathy Frey: 
    - https://www.youtube.com/watch?v=Y5RcMWiUyyE

    input: [remainder], [modulor]
    output: n 

    >>> rem5 = [3346, 2096, 730]
    >>> mod5 = [7919, 12553, 17389]
    >>> Crt(rem5, mod5)._compute_smallest_n()
    >>> 1710316275532
    """

    def __init__(self, rem_list, mod_list):
        self.rem_list = rem_list
        self.mod_list = mod_list

    def _isRemainderOne(self, x_i, b_i, mod_i):
        return (((x_i * b_i) % mod_i) == 1) 

    def _find_x(self, B, b, max_n = sys.maxint):
        """
        find x, a value such that when multiplied with b congruences to 1
        """
        result = []
        for (b_i, mod_i) in zip(b, self.mod_list):
            #for x_i in xrange(1, max_n):
            #    if self._isRemainderOne(x_i, b_i, mod_i):
            #        result.append(x_i)
            #        break
            #    x_i += 1
                
            # use fermet theorm
            x_i = (b_i ** (mod_i - 2) ) 
            result.append(x_i)
        return result

    def _compute_smallest_n(self):
        assert len(self.rem_list) == len(self.mod_list)
        # B is the multiplication of the modulors
        B = reduce(lambda x,y: x*y, self.mod_list) 
        b = [B/i for i in self.mod_list]
        x = self._find_x(B,b)
        c_b_x = zip(self.rem_list, b, x)
        n = (sum([reduce(lambda x,y: x * y, i) for i in c_b_x])) % B
        return n


def test():
    rem1 = [2,3,2]
    mod1 = [3,5,7]
    n1 = Crt(rem1, mod1)._compute_smallest_n()
    assert n1 == 23

    rem2 = [8,9,8]
    mod2 = [9,11,13]
    n2 = Crt(rem2, mod2)._compute_smallest_n()
    assert n2 == 944

    rem3 = [2,3,2]
    mod3 = [3,5,7]
    n3 = Crt(rem3, mod3)._compute_smallest_n()
    assert n3 == 23

    rem4 = [6,5]
    mod4 = [7,11]
    n4 = Crt(rem4, mod4)._compute_smallest_n()
    assert n4 == 27

    rem5 = [3346, 2096, 730]
    mod5 = [7919, 12553, 17389]
    n5 = Crt(rem5, mod5)._compute_smallest_n()
    assert n5 == 1710316275532

if __name__ == "__main__":
    test()
