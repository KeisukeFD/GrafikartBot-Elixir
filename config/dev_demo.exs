config :discordbot,
  admin: 123123123, # Who can execute admin commands
  api_key: "YOUR API KEY HERE", # API key to access discord API
  # Force a message pattern inside a channel
  filters: [
    {channel_id, ~r/^(\[[^\]]+\]|<\:[a-z0-9]+\:[0-9]+>) .+ https?:\/\/\S*$/}
  ]