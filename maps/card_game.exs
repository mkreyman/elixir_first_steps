defmodule CardGame do
  import Enum

  def deck do
    for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit,rank]
  end

  def hand(deck) do
    deck |> shuffle |> take(13)
  end

  def hands(deck) do
    deck |> shuffle |> chunk(13)
  end
end