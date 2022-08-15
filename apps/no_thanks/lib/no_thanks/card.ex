defmodule NoThanks.Card do
  defstruct value: 0,
            chips: 0

  @type t :: %__MODULE__{
          value: pos_integer(),
          chips: non_neg_integer()
        }

  def new(opts \\ []) do
    struct(%__MODULE__{}, opts)
  end

  def add_chips(card, amount) do
    struct(card, chips: card.chips + amount)
  end
end
