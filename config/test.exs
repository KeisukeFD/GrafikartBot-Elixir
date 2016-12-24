use Mix.Config

config :discordbot,
  test: true,
  admin: 100,
  filters: [
    {200, ~r/^(\[[^\]]+\]|<\:[a-z0-9]+\:[0-9]+>) .+ https?:\/\/\S*$/}
  ],
  commands: [
    demo: "demo @user - @content"
  ]