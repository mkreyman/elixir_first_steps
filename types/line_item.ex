defmodule LineItem do
  defstruct sku: "", quantity: 1

  @type t :: %LineItem{sku: String.t, quantity: integer}
end

# You can then reference this type as LineItem.t