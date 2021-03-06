defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    #|> IO.inspect
    |> Enum.map(&String.graphemes(&1))
    #|> IO.inspect
    |> Enum.map(&pigify(&1))
    #|> IO.inspect
    |> Enum.join(" ")
  end

  defp pigify(["q", "u" | t]), do: t ++ ["quay"]

  defp pigify(["y", x | _] = word) when x not in ~w(a e i o u) do
    word ++ ["ay"]
  end

  defp pigify(["x", y | _] = word) when y not in ~w(a e i o u) do
    word ++ ["ay"]
  end

  defp pigify([h | _] = word) when h in ~w(a e i o u) do
    word ++ ["ay"]
  end

  defp pigify([h | t]) do
    pigify(t ++ [h])
  end
end
