defmodule PhoenixTrello.List do
  use PhoenixTrello.Web, :model

  @derive {Poison.Encoder, only: [:id, :board_id, :name, :position, :cards]}

  schema "lists" do
    field :name, :string
    field :position, :integer

    belongs_to :board, PhoenixTrello.Board
    has_many :cards, PhoenixTrello.Card

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :position])
    |> validate_required([:name])
    |> calculate_position()
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :position])
  end

  defp calculate_position(current_changeset) do
    model = current_changeset.model

    query = from(l in PhoenixTrello.List,
            select: l.position,
            where: l.board_id == ^(model.board_id),
            order_by: [desc: l.position],
            limit: 1)

    case Repo.one(query) do
      nil      -> put_change(current_changeset, :position, 1024)
      position -> put_change(current_changeset, :position, position + 1024)
    end
  end
end
