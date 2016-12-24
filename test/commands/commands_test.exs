defmodule Discordbot.CommandsTest do

  use ExUnit.Case

  setup do
    {:ok, state: %{rest_client: self()}}
  end

  test "command is detected", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => "!demo <@123123213> Salut"
    })
    Discordbot.Commands.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
    assert_receive {_, _, {_, :post, _, %{content: "demo <@123123213> - Salut"}}}
  end

  test "command is detected without user", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => "!demo Salut"
    })
    Discordbot.Commands.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
    assert_receive {_, _, {_, :post, _, %{content: "demo  - Salut"}}}
  end

end