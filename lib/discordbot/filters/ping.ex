defmodule Discordbot.Ping do
  @moduledoc """
  Handle capslock message 
  """

  alias DiscordEx.RestClient.Resources.User
  alias DiscordEx.RestClient.Resources.Channel

  def handle(:message_create, %{"content" => "ping", "author" => %{"id" => user_id}}, state) do
    %{"id" => channel_id} = User.create_dm_channel(state[:rest_client], user_id)
    spawn fn -> Channel.send_message(state[:rest_client], channel_id, %{content: "Hi! Friends!"}) end
    {:ok, state}
  end

  def handle(_type, _payload, state) do
    {:no, state}
  end 

end
