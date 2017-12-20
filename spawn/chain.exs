defmodule Chain do

  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self(),
             fn (_, send_to) ->
               spawn(Chain, :counter, [send_to])
             end

    # start the count by sending
    send last, 0

    # and wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# ~/workspace/elixir/first_steps> elixir -r spawn/chain.exs -e "Chain.run(10)"
# {2984, "Result is 10"}
# ~/workspace/elixir/first_steps> elixir -r spawn/chain.exs -e "Chain.run(100)"
# {3812, "Result is 100"}
# ~/workspace/elixir/first_steps> elixir -r spawn/chain.exs -e "Chain.run(1000)"
# {12824, "Result is 1000"}
# ~/workspace/elixir/first_steps> elixir -r spawn/chain.exs -e "Chain.run(10000)"
# {91944, "Result is 10000"}
# ~/workspace/elixir/first_steps> elixir -r spawn/chain.exs -e "Chain.run(400_000)"

# 14:53:43.689 [error] Too many processes


# ** (SystemLimitError) a system limit has been reached
#     :erlang.spawn(Chain, :counter, [#PID<0.74.8>])
#     spawn/chain.exs:13: anonymous fn/2 in Chain.create_processes/1
#     (elixir) lib/enum.ex:1841: Enum.reduce_range_inc/4
#     spawn/chain.exs:11: Chain.create_processes/1
#     (stdlib) timer.erl:197: :timer.tc/3
#     spawn/chain.exs:27: Chain.run/1
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
# ~/workspace/elixir/first_steps> elixir --erl "+P 1000000" -r spawn/chain.exs -e "Chain.run(400_000)"
# {3028072, "Result is 400000"}
# ~/workspace/elixir/first_steps> elixir --erl "+P 1000000" -r spawn/chain.exs -e "Chain.run(1_000_000)"
# {7280844, "Result is 1000000"}