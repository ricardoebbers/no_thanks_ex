defmodule NoThanks.Tally do
  alias NoThanks.Card

  defstruct cards: [],
            chips: 0,
            score: 0

  @type t :: %__MODULE__{
          cards: list(Card.t()),
          chips: non_neg_integer(),
          score: non_neg_integer()
        }

  def new(opts \\ []) do
    struct(%__MODULE__{}, opts)
  end

  def pay(tally, cost) do
    struct(tally, chips: tally.chips - cost)
  end

  def take_card(tally, card) do
    struct(tally, cards: [card | tally.cards], chips: tally.chips + card.chips)
  end

  def calculate_score(tally) do
    chunk_fun = fn elem, acc ->
      cond do
        acc == [] -> {:cont, [elem]}
        abs(elem - hd(acc)) > 1 -> {:cont, [hd(acc)], [elem]}
        true -> {:cont, [elem]}
      end
    end

    after_fun = fn
      acc -> {:cont, acc, []}
    end

    sorted_cards =
      tally.cards
      |> Enum.sort_by(& &1.value, :desc)

    score =
      sorted_cards
      |> Enum.map(& &1.value)
      |> Enum.chunk_while([], chunk_fun, after_fun)
      |> List.flatten()
      |> Enum.sum()
      |> Kernel.-(tally.chips)

    struct(tally, cards: sorted_cards, score: score)
  end
end
