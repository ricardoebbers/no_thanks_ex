defmodule NoThanks.Action do
  alias NoThanks.Game

  @callback can?(game :: Game.t()) :: boolean()
  @callback perform(game :: Game.t()) :: Game.t()
end
