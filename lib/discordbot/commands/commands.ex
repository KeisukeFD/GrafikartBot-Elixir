defmodule Discordbot.Commands do

  alias DiscordEx.RestClient.Resources.Channel

  def handle(:message_create, data = %{"content" => "!" <> command}, state = %{rest_client: conn}) do
    commands = Application.get_env(:discordbot, :commands)
    command = parse_command(command)
    if Keyword.has_key?(commands, command.name) do
      spawn fn -> Channel.delete_message(conn, data["channel_id"], data["id"]) end
      spawn fn -> Channel.send_message(conn, data["channel_id"], %{content: message(command)}) end
    end
    {:ok, state}
  end

  def handle(_type, _data, state) do
    {:ok, state}
  end

  defp parse_command(command) do
    splits = String.split(command)
    command = List.first(splits) |> String.to_atom
    splits = Enum.drop(splits, 1)
    splits_length = Kernel.length(splits)
    if splits_length > 0 do
      if String.at(Enum.at(splits, 0), 1) == "@" do
        %{
          name: command,
          user: Enum.at(splits, 0),
          content: Enum.drop(splits, 1) |> Enum.join(" ")
        }
      else
        %{
          name: command,
          user: "",
          content: Enum.join(splits, " ")
        }
      end
    else
      %{
        name: command,
        user: "",
        content: ""
      }
    end
  end

  defp message(command) do
    Application.get_env(:discordbot, :commands)[command.name]
      |> String.replace("@content", command.content)
      |> String.replace("@user", command.user)
  end

end