defmodule Discordbot.Commands.Admin do

  @doc """
  Changement du nom d'utilisateur
  """
  def handle(:message_create, payload = %{"content" => ("!username " <> username)}, state = %{rest_client: conn}) do
    if is_admin?(payload) do
      DiscordEx.RestClient.resource(conn, :patch, "users/@me", %{username: username})
    end
    {:ok, state}
  end

  @doc """
  Changement de l'avatar
  """
  def handle(:message_create, payload = %{"content" => ("!avatar " <> avatar_url)}, state = %{rest_client: conn}) do
    if is_admin?(payload) do
      {:ok, %{body: body}} = HTTPoison.get(avatar_url)
      DiscordEx.RestClient.resource(conn, :patch, "users/@me", %{avatar: "data:image/jpeg;base64," <> :base64.encode(body)})
    end
    {:ok, state}
  end

  def handle(_type, _data, state) do
    {:ok, state}
  end

  defp is_admin?(payload) do
    Application.get_env(:discordbot, :admin) == payload["author"]["id"]
  end

end