defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins = 
      rna
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> IO.inspect
      |> Enum.map(&Enum.join/1)
      |> IO.inspect
      |> Enum.map(&ProteinTranslation.of_codon/1)
      |> IO.inspect
      |> Enum.take_while(fn {_, protein} -> protein != "STOP" end)

    Enum.find(
      proteins,
      {:ok, Enum.map(proteins, fn {_, protein} -> protein end)},
      fn {status, _} -> status == :error end
    )
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    cond do
      String.length(codon) != 3 -> {:error, "invalid codon"}
      codon in ["UGU", "UGC"] -> {:ok, "Cysteine"}
      codon in ["UUA", "UUG"] -> {:ok, "Leucine"}
      codon in ["AUG"] -> {:ok, "Methionine"}
      codon in ["UUU", "UUC"] -> {:ok, "Phenylalanine"}
      codon in ["UCU", "UCC", "UCA", "UCG"] -> {:ok, "Serine"}
      codon in ["UGG"] -> {:ok, "Tryptophan"}
      codon in ["UAU", "UAC"] -> {:ok, "Tyrosine"}
      codon in ["UAA", "UAG", "UGA"] -> {:ok, "STOP"}
      true -> {:error, "invalid RNA"}
    end
  end

  def teste do
    string = IO.gets("Digite os codons:")
    IO.inspect(string)
    of_codon(String.to_charlist(String.trim(string)))
  end
end
