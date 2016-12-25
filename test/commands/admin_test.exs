defmodule Discordbot.Commands.AdminTest do

  use ExUnit.Case, async: true

  setup do
    {:ok, state: %{rest_client: self()}}
  end

  test "A non admin user can't use admin commands", %{state: state} do
    message = DiscordbotTest.message(%{
      "content"=> "!username bot",
    })
    Discordbot.Commands.Admin.handle(:message_create, message, state)
    refute_receive {_, _, {_, :delete, _, _}}
    refute_receive {_, _, {_, :patch, _, _}}
  end

  test "change username", %{state: state} do
    message = DiscordbotTest.message(%{
      "content"=> "!username bot",
      "author" => %{
        "id" => Application.get_env(:discordbot, :admin)
      }
    })
    Discordbot.Commands.Admin.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
    assert_receive {_, _, {_, :patch, _, _}}
  end

  test "send all message", %{state: state} do
    message = DiscordbotTest.message(%{
      "content"=> "!all bot",
      "author" => %{
        "id" => Application.get_env(:discordbot, :admin)
      }
    })
    Discordbot.Commands.Admin.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
    assert_receive {_, _, {_, :post, _, _}}
  end

  test "send a message to a specific channel", %{state: state} do
    message = DiscordbotTest.message(%{
      "content"=> "! <#1234> bot",
      "author" => %{
        "id" => Application.get_env(:discordbot, :admin)
      }
    })
    Discordbot.Commands.Admin.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
    assert_receive {_, _, {_, :post, "channels/1234/messages", _}}
  end

end