defmodule PhoenixTrello.CardMember do
  use PhoenixTrello.Web, :model

  schema "card_members" do
    belongs_to :card, PhoenixTrello.Card
    belongs_to :user_board, PhoenixTrello.UserBoard
    has_one :user, through: [:user_board, :user]

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:card_id, :user_board_id])
    |> validate_required([:card_id, :user_board_id])
  end

  def get_by_card_and_user_board(query \\ %{}, card_id, user_board_id) do
    from cm in query,
    where: cm.card_id == ^card_id and cm.user_board_id == ^user_board_id,
    limit: 1
  end
end
