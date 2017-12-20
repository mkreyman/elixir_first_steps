defmodule Frequency do
  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
  end

  def add_word(word) do
    Agent.update(__MODULE__,
                 fn dict ->
                   Dict.update(dict, word, 1, &(&1+1))
                 end)
  end

  def count_for(word) do
    Agent.get(__MODULE__, fn dict -> Dict.get(dict, word) end)
  end

  def words do
    Agent.get(__MODULE__, fn dict -> Dict.keys(dict) end)
  end
end

# iex(13)> Frequency.start_link
# {:ok, #PID<0.109.0>}
# iex(14)> Frequency.add_word "dave"
# :ok
# iex(15)> Frequency.words
# ["dave"]
# iex(16)> Frequency.add_word "was"
# :ok
# iex(17)> Frequency.add_word "here"
# :ok
# iex(18)> Frequency.add_word "he"
# :ok
# iex(19)> Frequency.add_word "was"
# :ok
# iex(20)> Frequency.words
# ["he", "dave", "was", "here"]
# iex(21)> Frequency.count_for("dave")
# 1
# iex(22)> Frequency.count_for("was")
# 2