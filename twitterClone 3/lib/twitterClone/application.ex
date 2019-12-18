defmodule TwitterClone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
      
      
        :ets.new(:clientsregistry, [:set, :public, :named_table])
        :ets.new(:userTweets, [:set, :public, :named_table])
        :ets.new(:hashtagsTweets, [:set, :public, :named_table])
        :ets.new(:following, [:set, :public, :named_table])
        :ets.new(:followers, [:set, :public, :named_table])
        :ets.new(:mentions, [:set, :public, :named_table])
    children = [
      # Start the Ecto repository
      TwitterClone.Repo,
      # Start the endpoint when the application starts
      TwitterCloneWeb.Endpoint
      # Starts a worker by calling: TwitterClone.Worker.start_link(arg)
      # {TwitterClone.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwitterClone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TwitterCloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
