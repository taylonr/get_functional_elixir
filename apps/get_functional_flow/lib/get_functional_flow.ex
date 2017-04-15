defmodule GetFunctionalFlow do
  @moduledoc """
  Documentation for GetFunctionalFlow.
  """

  def benchmark(fun) do
    fun
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  @doc """
  Determines the number of words in a file

    ### Example
    iex> GetFunctionalFlow.benchmark(&GetFunctionalFlow.flow_count/0)

  """
  def flow_count do

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

  @doc """
  Determines the number of words in a file

    ### Example
    iex> GetFunctionalFlow.benchmark(&GetFunctionalFlow.stream_count/0)
  """
  def stream_count do
    File.stream!(Path.join(:code.priv_dir(:get_functional_flow), "kjv.txt"))
    |> Stream.flat_map(&String.split(&1, [" ", "\n"], trim: true))
    |> Stream.map(&String.downcase/1)
    |> Enum.reduce(%{}, fn word, acc ->
            Map.update(acc, word, 1, & &1 + 1)
        end)
    |> Enum.sort(fn first, second -> elem(first, 1) > elem(second, 1) end)
  end
end
