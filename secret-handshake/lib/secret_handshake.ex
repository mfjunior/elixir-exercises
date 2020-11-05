defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(0), do: []
  def commands(1), do: ["wink"]
  def commands(x) when x >= 16, do: Enum.reverse(commands(x - 16))
  def commands(x) when x >= 8, do: commands(x - 8) ++ ["jump"]
  def commands(x) when x >= 4, do: commands(x - 4) ++ ["close your eyes"]
  def commands(x) when x >= 2, do: commands(x - 2) ++ ["double blink"] 
end
