Code.require_file "tasks1.exs", __DIR__

worker = Task.async(Fib, :of, [20])
result = Task.await(worker)
IO.puts "The result is #{result}"