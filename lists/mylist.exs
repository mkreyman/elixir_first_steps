defmodule MyList do
  # def span(from, to) do
  #   from..to
  #   |> Enum.reduce([], fn i, acc -> [i | acc] end)
  #   |> Enum.reverse()
  # end

  def span(from, to), do: Enum.to_list(from..to)
end