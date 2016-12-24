defmodule Discordbot.Filters.Links do

  alias DiscordEx.RestClient.Resources.Channel

  def handle(:message_create, data, state = %{rest_client: conn}) do
    case List.keyfind(Application.get_env(:discordbot, :filters), data["channel_id"], 0) do
      {channel_id, filter} ->
        if !Regex.run(filter, data["content"]) do
          spawn fn -> Channel.delete_message(conn, channel_id, data["id"]) end
        end
      _ -> nil
    end
    {:ok, state}
  end

  def handle(_type, _data, state) do
    {:ok, state}
  end

end