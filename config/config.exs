# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :discordbot,
  capslock: ":scream_cat: Pas la peine de hurler @user",
  code: [
    message: ":space_invader: Woops trop de code @user @link",
    dm: """
    Hey !

    Je viens de remarquer que tu as posté pas mal de code sur le chan Grafikart.

    Poster des gros morceaux de code n'est pas super pratique pour la lisibilité, aussi n'hésite pas à copier ton code sur un service tier comme hastebin.com.
    Tu peux optimiser tes chances d'avoir une réponse en utilisant ce template : http://hastebin.com/uzufecurol.php .

    ```
    @code
    ```
    """
  ],
  insults: [
    badwords: ~w(pute connard enculé bite ntm pd fdp tepu salope conasse iench pétasse catin bouffone bouffon truie),
    dm: """
    Hey ! pas d'insulte sur le chan, votre message a été supprimé :disappointed_relieved:
    ```
    @content
    ```
    """
  ],
  commands: [
    troll: "https://www.youtube.com/watch?v=VjA9uJ2dFCI",
    google: ":mag: @user Tu devrais trouver ton bonheur sur google https://www.google.fr/?gws_rd=ssl#q=@content",
    php: ":mag: @user Je pense que cette fonction devrait t'aider http://php.net/search.php?show=quickref&pattern=@content",
    grafikart: ":mag: @user Il y a surement déjà un tutoriel sur le sujet https://www.grafikart.fr/search?q=@content",
  ]

config :porcelain, goon_warn_if_missing: false

import_config "#{Mix.env}.exs"