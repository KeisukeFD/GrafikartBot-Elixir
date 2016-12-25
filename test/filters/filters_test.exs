defmodule Discordbot.FiltersTest do

  use ExUnit.Case, async: true

  @link "[DOCKER] à l'occasion du docker birthday, un git hub avec un cours et un TP: https://github.com/docker/docker-birthday-3"
  @badlink "[Test] dlzpepflef htttttp://google..fr"

  setup do
    {:ok, state: %{rest_client: self()}}
  end

  test "should allow link with emoticon", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => "<:css3:250692379638497280> some text http://demolink.fr",
      "channel_id" => 200
    })
    Discordbot.Filters.handle(:message_create, message, state)
    refute_receive {_, _, {_, :delete, _, _}}
  end

  test "should reject bad links", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => "Voila mon lien https://github.com/docker/docker-birthday-3",
      "channel_id" => 200
    })
    Discordbot.Filters.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
  end

  test "should delete incorrect link", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => @badlink,
      "channel_id" => 200
    })
    Discordbot.Filters.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
  end

  test "should not delete correct link", %{state: state} do
    message = DiscordbotTest.message(%{
      "content" => @link,
      "channel_id" => 200
    })
    Discordbot.Filters.handle(:message_create, message, state)
    refute_receive {_, _, {_, :delete, _, _}}
  end

end