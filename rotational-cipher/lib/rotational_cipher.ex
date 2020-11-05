defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(fn(char) -> rotate_character(char, shift) end)
    |> List.to_string()
  end

  defp rotate_character(char, amount) when char in ?a..?z, do: rem(char - ?a + amount, 26) + ?a
  defp rotate_character(char, amount) when char in ?A..?Z, do: rem(char - ?A + amount, 26) + ?A
  defp rotate_character(char, _), do: char
end
