defmodule Hastebin do
  
  def send(data) do
    case HTTPoison.post "https://hastebin.com/documents", data, [{"Content-Type", "application/json"}] do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"key" => key} = Poison.decode!(body)
        {:ok, "https://hastebin.com/" <> key}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ko, "Not found :("}
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

end