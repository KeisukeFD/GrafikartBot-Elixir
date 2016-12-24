defmodule Hastebin.Test do

  use ExUnit.Case, async: true
  
  test "send a hastebin" do
    assert {:ok, _} = Hastebin.send("This is some data")
  end

end