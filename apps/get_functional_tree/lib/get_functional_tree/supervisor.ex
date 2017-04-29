defmodule GetFunctionalTree.Supervisor do
    use Supervisor
    def start_link(balance) do
        result = {:ok, sup} = Supervisor.start_link(__MODULE__, [balance])
        start_workers(sup, balance)
        result
    end

    def start_workers(sup, balance) do
        {:ok, stash} = Supervisor.start_child(sup, worker(GetFunctionalTree.Stash, [balance]))
        Supervisor.start_child(sup, supervisor(GetFunctionalTree.SubSupervisor, [stash]))
    end

    def init(_) do
        supervise [], strategy: :one_for_one
    end
end