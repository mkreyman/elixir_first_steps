defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition={name,_,args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
        result
      end
    end
  end
end

defmodule Test do
  import Kernel, except: [def: 2]
  import Tracer, only: [def: 2]

  def puts_sum_three(a,b,c), do: IO.inspect(a+b+c)
  def add_list(list), do: Enum.reduce(list, 0, &(&1+&2))
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])

# iex(2)> c "tracer3.ex"
# warning: redefining module Tracer (current version defined in memory)
#   tracer3.ex:1

# warning: redefining module Test (current version defined in memory)
#   tracer3.ex:22

# ==> call: puts_sum_three(1, 2, 3)
# 6
# <== result: 6
# ==> call: add_list([5, 6, 7, 8])
# <== result: 26
# [Test, Tracer]