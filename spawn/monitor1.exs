defmodule Monitor1 do
  import :timer, only: [ sleep: 1 ]

  def sad_method do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor1, :sad_method, [])
    IO.puts inspect res

    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
      after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Monitor1.run

# ~/workspace/elixir/first_steps/spawn> elixir -r link3.exs
# MESSAGE RECEIVED: {:EXIT, #PID<0.79.0>, :boom}
# ~/workspace/elixir/first_steps/spawn> elixir -r monitor1.exs -e Monitor1.run
# {#PID<0.79.0>, #Reference<0.2707412353.1837367300.34915>}
# MESSAGE RECEIVED: {:DOWN, #Reference<0.2707412353.1837367300.34915>, :process, #PID<0.79.0>, :boom}
# {#PID<0.80.0>, #Reference<0.2707412353.1837367297.34945>}
# MESSAGE RECEIVED: {:DOWN, #Reference<0.2707412353.1837367297.34945>, :process, #PID<0.80.0>, :boom}