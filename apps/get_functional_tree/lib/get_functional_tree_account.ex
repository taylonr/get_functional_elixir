defmodule GetFunctionalTree.Account do
  use GenServer

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: :account)
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

  def init(stash_pid) do
    balance = GetFunctionalTree.Stash.get_value(stash_pid)
    {:ok, {balance, stash_pid}}
  end

  def handle_call({:credit, amount}, _from, {state, stash_pid}) do
    {:reply, state + amount, {state + amount, stash_pid}}
  end

  def handle_call({:debit, amount}, _from, {state, stash_pid}) do
    {:noreply, state - amount, {state - amount, stash_pid}}
  end

  def handle_call(:balance, _from, state) do
    {:reply, elem(state, 0), state}
  end

  def terminate(_reason, {balance, stash_pid}) do
    GetFunctionalTree.Stash.save_value(stash_pid, balance)
  end

  def handle_cast({:crash}, _state) do
    Process.whereis(:account)
    |> Process.exit(:kill)
  end
end
