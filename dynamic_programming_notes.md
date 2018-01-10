# Dynamic Programming

## Top Down (Recursive)
Memoization 
Typical of recursive implementations the depend on solutions further down the chain
Build your stacks and save the work to a cache as you bubble up - subsequent calls to the same function within any given stack can pull the answer out of the cache without incurring more function calls

## Bottom up (Iterative)

Use smaller solutions as basis of later/larger solutions 
(iterative)
builds from ground up 

## Memoized/Dynamic Fibonacci (Top Down)

Initialize a cache outside function when calculating fibonacci 

You can also pass the cache as a parameter 
```
@cache = { 1: 1, 2: 1, 3: 2 }

def fib(n)
  return @cache[n] if @cache[n]
  ans = fib(n-1) + fib(n-2)
  @cache[n] = ans
  ans
end 
```

### Bottom Up
```
def fib(n)
  cache = {1:1, 2:1, 3:2}
  (3..n).each do |i|
  cache[i] = cache[i-1] + cache[i-2]
  end 
cache 
```

## Longest Increasing Subsequence 
Given array of integers find the length of the longets increasing subsequence
[1,5,2,6,10,4,20] => 5 (1, 2, 6, 10, 20) or (1, 5, 6, 10, 20)
Recursion relationship 
[1] => 1
What is "solution" of [1, 5] => 1, 5
[1,5,2] => 1, 2
[1,5,2,6] => 1, 2, 6 favor later elements
[1,5,2,6,10] => 1, 2, 6, 10
[1,5,2,6,10,4] 1, 2, 4 (best answer that terminates in a 4)
[1,5,2,6,10,4,20] => 1, 2, 6, 10, 20 

If we knew longest sequence that ended in element 1 and longest sequence in element 2, and element 3 and element 4....etc, then we can determine which is best because it will be in that set.

Go backwards and find the last solution that terminates in something less than what we were trying to adjoin.

Accumulate optimal solutions for every index then choose among those. 


