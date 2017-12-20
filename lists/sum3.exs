defmodule MyList do
  def sum([]), do: 0
  def sum([ total | [] ]), do: total
  def sum([ total | [ head | tail ]]) do
    sum([ total + head | tail])
  end
end