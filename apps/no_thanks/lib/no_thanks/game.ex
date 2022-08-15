defmodule NoThanks.Game do
  alias NoThanks.{
    Action.Pass,
    Action.Take,
    Deck,
    Game,
    Player
  }

  defstruct deck: Deck.new(),
            roster: :queue.new(),
            turn: nil,
            card: nil,
            winner: nil

  @type t :: %__MODULE__{
          deck: list(Deck.t()),
          roster: :queue.queue(Player.t()),
          turn: Player.t() | nil,
          card: Card.t() | nil,
          winner: Player.t() | nil
        }

  @default_chips 11
  @take_out_cards 9

  def new(opts \\ []) do
    deck =
      opts
      |> Deck.new()
      |> Deck.shuffle()
      |> Deck.take_out(@take_out_cards)

    %__MODULE__{deck: deck}
  end

  def add_players(game, players) do
    Enum.reduce(players, game, &Game.add_player(&2, &1))
  end

  def add_player(game, player_name) do
    opts = [chips: @default_chips, name: player_name]
    struct(game, roster: :queue.in(Player.new(opts), game.roster))
  end

  def start(game) do
    game
    |> next_turn()
    |> pull_card()
  end

  def next_turn(game = %{turn: nil}) do
    {{:value, player}, roster} = :queue.out(game.roster)
    struct(game, turn: player, roster: roster)
  end

  def next_turn(game) do
    {{:value, player}, roster} =
      game.turn
      |> :queue.in(game.roster)
      |> :queue.out()

    struct(game, turn: player, roster: roster)
  end

  def pull_card(game = %{card: nil}) do
    {deck, card} = Deck.pull_card(game.deck)
    struct(game, deck: deck, card: card)
  end

  def pull_card(game), do: game

  def play(game, action) do
    cond do
      action == Pass && action.can?(game) ->
        game
        |> action.perform()
        |> next_turn()
        |> pull_card()

      Take.can?(game) ->
        game
        |> Take.perform()
        |> pull_card()

      true ->
        finish(game)
    end
  end

  def finish(game) do
    roster_with_scores =
      game.turn
      |> :queue.in(game.roster)
      |> :queue.to_list()
      |> Enum.map(&Player.calculate_score(&1))

    winner =
      roster_with_scores
      |> Enum.sort_by(& &1.tally.score, :asc)
      |> List.first()

    struct(game, turn: nil, roster: roster_with_scores, winner: winner)
  end
end
