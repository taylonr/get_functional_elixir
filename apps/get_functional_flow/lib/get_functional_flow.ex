defmodule GetFunctionalFlow do
  @moduledoc """
  Documentation for GetFunctionalFlow.
  """

  @doc """
  Determines the number of words in a file
  """
  def word_count do

    File.stream!(Path.join(:code.priv_dir(:get_functional_flow), "kjv.txt"))
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, [" ", "\n"], trim: true))
    |> Flow.map(&String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, & &1 + 1)
    end)
    |> Enum.to_list()
    |> Enum.sort(fn first, second -> elem(first, 1) > elem(second, 1) end)
  end
end
