defmodule NoThanks.Action.Take do
  alias NoThanks.{
    Action,
    Player
  }

  @behaviour Action

  @impl true
  def can?(game) do
    not is_nil(game.card)
  end

  @impl true
  def perform(game) do
    struct(game,
      turn: Player.take_card(game.turn, game.card),
      card: nil
    )
  end
end
