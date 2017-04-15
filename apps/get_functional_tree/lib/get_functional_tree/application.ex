defmodule GetFunctionalTree.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, _pid} = GetFunctionalTree.Supervisor.start_link(0)
  end
end
