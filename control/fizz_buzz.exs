fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, third -> "#{third}"
end

fizz_buzz_rem = fn n ->
  fizz_buzz.(rem(n,3), rem(n,5), n)
end

# IO.puts fizz_buzz.(0, 0, "first clause")
# IO.puts fizz_buzz.(0, "second", "also second")
# IO.puts fizz_buzz.("third clause", 0, "also third")
# IO.puts fizz_buzz.("forth", "also forth", "this should get displayed")

IO.puts fizz_buzz_rem.(10)
IO.puts fizz_buzz_rem.(11)
IO.puts fizz_buzz_rem.(12)
IO.puts fizz_buzz_rem.(13)
IO.puts fizz_buzz_rem.(14)
IO.puts fizz_buzz_rem.(15)
IO.puts fizz_buzz_rem.(16)



