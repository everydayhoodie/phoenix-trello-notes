defmodule PhoenixTrello.UserBoard do
  use PhoenixTrello.Web, :model

  schema "user_boards" do
    belongs_to :user, PhoenixTrello.User
    belongs_to :board, PhoenixTrello.Board

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
    |> unique_constraint(:user_id, name: :user_boards_user_id_board_id_index)
  end

  def find_by_user_and_board(query \\ %{}, user_id, board_id) do
    from u in query,
    where: u.user_id == ^user_id and u.board_id == ^board_id
  end
end
