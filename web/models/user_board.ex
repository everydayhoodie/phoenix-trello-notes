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
end
