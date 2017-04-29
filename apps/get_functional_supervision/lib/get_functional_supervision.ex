defmodule GetFunctionalSupervision.Account do
  @moduledoc """
  Documentation for GetFunctionalSupervision.
  """

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0, name: :account)
  end

  def credit(amount) do
    GenServer.call(:account, {:credit, amount})
  end

  def debit(amount) do
    GenServer.call(:account, {:debit, amount})
  end

  def balance() do
    GenServer.call(:account, :balance)
  end

  def crash do
    GenServer.cast(:account, {:crash})
  end

  def get_pid do
    Process.whereis(:account)
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
    Process.whereis(:account)
    |> Process.exit(:kill)
  end
end

