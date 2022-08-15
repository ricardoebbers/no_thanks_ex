defmodule NoThanks.Deck do
  alias NoThanks.Card

  defstruct cards: []

  @default_cards 1..35

  def new(opts \\ []) do
    cards =
      opts
      |> Keyword.get(:cards, @default_cards)
      |> Enum.map(&Card.new(value: &1))

    struct(%__MODULE__{}, cards: cards)
  end

  def shuffle(deck) do
    struct(deck, cards: Enum.shuffle(deck.cards))
  end

  def take_out(deck, amount) do
    struct(deck, cards: Enum.drop(deck.cards, amount))
  end

  def pull_card(deck) do
    {card, rest} = List.pop_at(deck.cards, 0)
    {struct(deck, cards: rest), card}
  end
end
