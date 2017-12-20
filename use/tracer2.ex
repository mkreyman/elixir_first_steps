defmodule Tracer do
  defmacro def(definition, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        unquote(content)
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

# iex(1)> c "tracer2.ex"
# warning: redefining module Tracer (current version defined in memory)
#   tracer2.ex:1

# warning: redefining module Test (current version defined in memory)
#   tracer2.ex:11

# 6
# [Test, Tracer]