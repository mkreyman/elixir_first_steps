defmodule FibAgent do
  def start_link do
    cache = Enum.into([{0, 0}, {1, 1}], Map.new)
    Agent.start_link(fn -> cache end)
  end

  def fib(pid, n) when n >= 0 do
    Agent.get_and_update(pid, &do_fib(&1, n))
  end

  defp do_fib(cache, n) do
    if cached = cache[n] do
      {cached, cache}
    else
      {val, cache} = do_fib(cache, n - 1)
      result = val + cache[n-2]
      {result, Map.put(cache, n, result)}
    end
  end
end

{:ok, agent} = FibAgent.start_link()
IO.puts FibAgent.fib(agent, 2000)

# ~/workspace/elixir/first_steps/spawn> elixir fib_agent.exs
# 4224696333392304878706725602341482782579852840250681098010280137314308584370130707224123599639141511088446087538909603607640194711643596029271983312598737326253555802606991585915229492453904998722256795316982874482472992263901833716778060607011615497886719879858311468870876264597369086722884023654422295243347964480139515349562972087652656069529806499841977448720155612802665404554171717881930324025204312082516817125
