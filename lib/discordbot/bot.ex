defmodule Discordbot.Bot do

  ## Client API
  def start_link(api_key) do
    DiscordEx.Client.start_link(%{
      token: api_key,
      handler: __MODULE__
    })
  end

  ## Server API
  def handle_event({type, %{data: data}}, state) do
    if data["author"]["id"] != state.client_id do
      # Discordbot.Capslock.handle(type, data, state)
      Discordbot.Code.handle(type, data, state)
      Discordbot.Ping.handle(type, data, state)
      Discordbot.Commands.Admin.handle(type, data, state)
    end
    {:ok, state}
  end

  def handle_event({_type, _payload}, state) do
    {:ok, state}
  end

end