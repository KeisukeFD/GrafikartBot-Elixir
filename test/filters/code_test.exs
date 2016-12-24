defmodule Discordbot.CodeTest do

  use ExUnit.Case, async: true

  setup do
    {:ok, state: %{rest_client: self()}}
  end

  test "should detect PHP Code" do
    code = """
    if(isset($_SESSION['id']) AND !empty($_SESSION['id']))
    {
        $id_planete_utilise=$_SESSION['planete_utilise'];
        $req_affichage_defense=$bdd->prepare('SELECT * FROM defense WHERE id_planete = ?');
        $req_affichage_defense->execute(array($id_planete_utilise));
        while($affichage_defense=$req_affichage_defense->fetch());
        $req_affichage_defense=$bdd->prepare('SELECT * FROM defense WHERE id_planete = ?');
        $req_affichage_defense->execute(array($id_planete_utilise));
        while($affichage_defense=$req_affichage_defense->fetch());
    }
    """
    assert Discordbot.Code.is_code(code) == true
  end

  test "should allow small piece of code" do
    code = """
    if(isset($_SESSION['id']) AND !empty($_SESSION['id'])){
        $id_planete_utilise=$_SESSION['planete_utilise'];
    }
    """
    assert Discordbot.Code.is_code(code) == false
  end

  test "should detect bash code" do
    code = """
    #!/bin/bash
   
    $server=$1
    $map=$2
    if [ map == 'tower' ]; then
      cd /servers/server;
   
    $server=$1
    $map=$2
    """
    assert Discordbot.Code.is_code(code) == true
  end

  test "should emit a private message", %{state: state} do
    message = Map.merge(DiscordbotTest.message, %{
      "content" => """
        if(isset($_SESSION['id']) AND !empty($_SESSION['id']))
        {
            $id_planete_utilise=$_SESSION['planete_utilise'];
            $req_affichage_defense=$bdd->prepare('SELECT * FROM defense WHERE id_planete = ?');
            $req_affichage_defense->execute(array($id_planete_utilise));
            while($affichage_defense=$req_affichage_defense->fetch());
            $req_affichage_defense=$bdd->prepare('SELECT * FROM defense WHERE id_planete = ?');
            $req_affichage_defense->execute(array($id_planete_utilise));
            while($affichage_defense=$req_affichage_defense->fetch());
        }
      """
    })
    Discordbot.Code.handle(:message_create, message, state)
    assert_receive {_, _, {_, :delete, _, _}}
  end

end