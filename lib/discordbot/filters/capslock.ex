defmodule Discordbot.Capslock do
  @moduledoc """
  Handle capslock message 
  """

  alias DiscordEx.RestClient.Resources.Channel
  alias Discordbot.Helpers.Message

  def handle(:message_create, %{"content" => content, "channel_id" => channel_id, "author" => %{"id" => user_id}}, state) do
    spawn fn ->
      if content == String.upcase(content) and String.length(content) > 15 do
        message = Application.get_env(:discordbot, :capslock)
          |> String.replace("@user", Message.mention(user_id))
        Channel.send_message(state[:rest_client], channel_id, %{content: message})
      end
    end
    {:ok, state}
  end

  def handle(_type, _payload, state) do
    {:ok, state}
  end 

end
