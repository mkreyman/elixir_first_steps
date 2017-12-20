defmodule Bitmap do
  defstruct value: 0

  defimpl Access do
    use Bitwise

    def get(%Bitmap{value: value}, bit) do
      if (value &&& (1 <<< bit)) == 0, do: 0, else: 1
    end

    def get_and_update(bitmap = %Bitmap{value: value}, bit, accessor_fn) do
      old_value = get(bitmap, bit)
      new_value = accessor_fn.(old_value)
      value = (value &&& bnot( 1 <<< bit )) ||| (new_value <<< bit)
      %Bitmap{value: value}
    end
  end
end

# ~/workspace/elixir/first_steps/protocols> iex bitmap_access.exs
# Erlang/OTP 20 [erts-9.0.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

# ** (ArgumentError) Access is not a protocol
#     (elixir) lib/protocol.ex:76: Protocol.assert_protocol!/2
#     bitmap_access.exs:4: (module)
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6