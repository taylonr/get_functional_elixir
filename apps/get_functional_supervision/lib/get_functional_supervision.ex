defmodule GetFunctionalSupervision do
  @moduledoc """
  Documentation for GetFunctionalSupervision.
  """

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0, name: :sup)
  end

  def credit(amount) do
    GenServer.call(:sup, {:credit, amount})
  end

  def debit(amount) do
    GenServer.call(:sup, {:debit, amount})
  end

  def balance() do
    GenServer.call(:sup, :balance)
  end

  def crash do
    GenServer.cast(:sup, {:crash})
  end

  def handle_call({:credit, amount}, _from, state) do
    {:reply, state + amount, state + amount}
  end

  def handle_call({:debit, amount}, _from, state) do
    {:noreply, state - amount, state - amount}
  end

  def handle_call(:balance, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:crash}, _state) do
    Process.whereis(:sup)
    |> Process.exit(:kill)
  end
end