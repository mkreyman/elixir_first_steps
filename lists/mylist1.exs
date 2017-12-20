defmodule MyList do
  def square([]),              do: []
  def square([ head | tail ]), do: [ head*head | square(tail) ]

  def add_1([]),              do: []
  def add_1([ head | tail ]), do: [ head+1 | add_1(tail) ]

  def map([], _func),             do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  # def sum([], total), do: total
  # def sum([ head | tail ], total), do: sum(tail, head+total)

  def sum([]), do: 0
  def sum([ total | [] ]), do: total
  def sum([ total | [ head | tail ]]) do
    sum([ total + head | tail])
  end

  def max([]), do: 0
  def max([head | []]), do: head
  def max([ head | [head2 | tail] ]) when head >= head2, do: max([head | tail])
  def max([ head | [head2 | tail] ]) when head < head2, do: max([head2 | tail])

  def caesar(list, n) do
    list
    |> Enum.map(&add(&1, n))
    |> List.to_string
  end

  # ?a == 97, ?z == 122
  defp add(ch, n) when ch in ?a..?z do
    rem((ch - ?a + n), 26) + ?a
  end
  defp add(ch, _), do: ch
end
