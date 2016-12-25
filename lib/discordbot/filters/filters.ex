defmodule Discordbot.Filters do

  @moduledoc """
  Filter the content of a channel to force a format on message
  """

  alias DiscordEx.RestClient.Resources.Channel

  def handle(:message_create, data, state = %{rest_client: conn}) do
    case List.keyfind(Application.get_env(:discordbot, :filters), data["channel_id"], 0) do
      {channel_id, filter} ->
        if !Regex.run(filter, data["content"]) do
          spawn fn -> Channel.delete_message(conn, channel_id, data["id"]) end
          {:ok, state}
        else
          {:no, state}
        end
      _ -> {:no, state}
    end
  end

  def handle(_type, _data, state) do
    {:no, state}
  end

end