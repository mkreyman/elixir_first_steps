defmodule My do
  defmacro mydef(name) do
    quote do
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Test do
  require My

  [ :fred, :bert ] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.fred

# ~/workspace/elixir/first_steps/macros> elixir macro_no_binding.exs
# ** (CompileError) macro_no_binding.exs:11: invalid syntax in def x1()