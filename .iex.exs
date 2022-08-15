alias NoThanks.{
  Action.Pass,
  Action.Take,
  Card,
  Deck,
  Game,
  Player,
  Tally
}

game =
  Game.new()
  |> Game.add_player("Simba")
  |> Game.add_player("Raissa")
  |> Game.add_player("Ricardo")
  |> Game.add_player("Reginaldo")
  |> Game.add_player("João Lira")
  |> Game.add_player("João Rafael")
