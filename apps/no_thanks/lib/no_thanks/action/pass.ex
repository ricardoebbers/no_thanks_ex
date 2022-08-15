defmodule NoThanks.Action.Pass do
  alias NoThanks.{
    Action,
    Card,
    Player
  }

  @behaviour Action

  @cost 1

  @impl true
  def can?(game) do
    game.turn.tally.chips >= @cost
  end

  @impl true
  def perform(game) do
    struct(game,
      turn: Player.pay(game.turn, @cost),
      card: Card.add_chips(game.card, @cost)
    )
  end
end
