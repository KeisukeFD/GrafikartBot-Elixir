defmodule Discordbot.Commands.AdminTest do

  use ExUnit.Case, async: true

  setup do
    {:ok, state: %{rest_client: self()}}
  end

  @doc """
  test "change username", %{state: state} do
    message = DiscordbotTest.message(%{
      "content"=> "!username bot",
      "author" => %{
        "id" => Application.get_env(:discordbot, :admin)
      }
    })
    Discordbot.Commands.Admin.handle(:message_create, message, state)
    assert_receive {_, _, {_, :patch, "/users/@me", _}}
  end
  """

end