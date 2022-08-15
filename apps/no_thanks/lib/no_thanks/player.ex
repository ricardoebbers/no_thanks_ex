defmodule NoThanks.Player do
  alias NoThanks.Tally

  defstruct name: "",
            tally: Tally.new()

  @type t :: %__MODULE__{
          name: String.t(),
          tally: Tally.t()
        }

  def new(opts \\ []) do
    tally = Tally.new(opts)
    struct(%__MODULE__{}, [tally: tally] ++ opts)
  end

  def pay(player, cost) do
    struct(player, tally: Tally.pay(player.tally, cost))
  end

  def take_card(player, card) do
    struct(player, tally: Tally.take_card(player.tally, card))
  end

  def calculate_score(player) do
    struct(player, tally: Tally.calculate_score(player.tally))
  end
end
