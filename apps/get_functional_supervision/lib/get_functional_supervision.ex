defmodule GetFunctionalSupervision do
  @moduledoc """
  Documentation for GetFunctionalSupervision.
  """

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: :sup)
  end

  def get do
    GenServer.call(:sup, :get)
  end

  def set(value) do
    GenServer.cast(:sup, {:set, value})
  end

  def crash do
    GenServer.cast(:sup, {:crash})
  end


  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set, val}, state) do
    {:noreply, Map.put(state, :test, val)}
  end

  def handle_cast({:crash}, _state) do
    Process.whereis(:sup)
    |> Process.exit(:kill)
  end
end
