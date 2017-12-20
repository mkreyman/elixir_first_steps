defmodule Countdown do
  def sleep(seconds) do
    receive do
      after seconds*1000 -> nil
    end
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    Stream.resource(
      fn -> # the number of seconds to the start of the next minute
        {_h,_m,s} = :erlang.time
        60 - s - 1
      end,
      fn # wait for the next second, then return its countdown
        0 ->
          {:halt, 0}
        count ->
          sleep(1)
          { [inspect(count)], count - 1 }
      end,
      fn _ -> end # nothing to deallocate
    )
  end
end

iex(1)> counter = Countdown.timer
#Function<50.40091930/2 in Stream.resource/3>
iex(2)> printer = counter |> Stream.each(&IO.puts/1)
#Stream<[enum: #Function<50.40091930/2 in Stream.resource/3>,
 funs: [#Function<38.40091930/1 in Stream.each/2>]]>
iex(3)> speaker = printer |> Stream.each(&Countdown.say/1)
#Stream<[enum: #Function<50.40091930/2 in Stream.resource/3>,
 funs: [#Function<38.40091930/1 in Stream.each/2>,
  #Function<38.40091930/1 in Stream.each/2>]]>
iex(4)> speaker |> Enum.take(5)
19
18
17
16
15
["19", "18", "17", "16", "15"]
iex(5)> speaker |> Enum.take(5)
56
55
54
53
52
["56", "55", "54", "53", "52"]
iex(6)> speaker |> Enum.to_list
30
29
...
2
1
["30", "29", "28", "27", "26", "25", "24", "23", "22", "21", "20", "19", "18",
 "17", "16", "15", "14", "13", "12", "11", "10", "9", "8", "7", "6", "5", "4",
 "3", "2", "1"]