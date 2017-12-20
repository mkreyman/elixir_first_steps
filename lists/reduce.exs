defmodule MyList do
  def reduce([], value, _) do
    value
  end

  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def longest_word(words_list) do
    Enum.reduce(words_list, fn word, longest ->
      if String.length(word) > String.length(longest) do
        word
      else
        longest
      end
    end)
  end

  def longest_word2(words_list) do
    Enum.reduce(words_list, 0, fn word, longest ->
      if String.length(word) > longest do
        String.length(word)
      else
        longest
      end
    end)
  end
end

# iex(42)> MyList.longest_word(["now", "is", "the", "time"])
# "time"
# iex(47)> MyList.longest_word2(["now", "is", "the", "time"])
# 4
