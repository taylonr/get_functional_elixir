defmodule GetFunctionalTree.Stash do
    use GenServer

    def start_link(balance) do
        {:ok, _pid} = GenServer.start_link(__MODULE__, balance)
    end

    def save_value(pid, value) do
        GenServer.cast(pid, {:save_value, value})
    end

    def get_value(pid) do
        GenServer.call(pid, :get_value)
    end

    

    def handle_call(:get_value, _from, balance) do
        {:reply, balance, balance}
    end

    def handle_cast({:save_value, value}, _balance) do
        {:noreply, value}
    end
end