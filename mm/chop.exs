defmodule Chop do
  def guess(actual, low..high) do
    guessed = low + div(high - low, 2)
    IO.puts "Is it #{guessed}?"
    case compare(actual, guessed) do
      :equal_to_actual  -> guessed
      :less_than_actual -> guess(actual, guessed + 1..high)
      :more_than_actual -> guess(actual, low..guessed - 1)
    end
  end

  defp compare(actual, guessed) when actual == guessed, do: :equal_to_actual
  defp compare(actual, guessed) when actual > guessed,  do: :less_than_actual
  defp compare(actual, guessed) when actual < guessed,  do: :more_than_actual
end


# iex(42)> Chop.guess(273, 1..1000)
# Is it 500?
# Is it 250?
# Is it 375?
# Is it 312?
# Is it 281?
# Is it 265?
# Is it 273?
# 273