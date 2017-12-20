defmodule Exercises do

  # calculate the sum of the integers from 1 to n
  def sum(1), do: 1
  def sum(n), do: n + sum(n-1)

  # the greatest common divisor between two nonnegative integers
  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end



