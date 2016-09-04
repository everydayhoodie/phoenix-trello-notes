defmodule PhoenixTrello.Card do
  use PhoenixTrello.Web, :model

  @derive {Poison.Encoder, only: [:id, :list_id, :name]}

  schema "cards" do
    field :name, :string
    field :description, :string
    field :position, :integer
    field :tags, {:array, :string}

    belongs_to :list, PhoenixTrello.List
    has_many :comments, PhoenixTrello.Comment
    has_many :card_members, PhoenixTrello.CardMember
    has_many :members, through: [:card_members, :user]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :list_id, :description, :position, :tags])
    |> validate_required([:name, :list_id])
    |> calculate_position()
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :list_id, :description, :position, :tags])
  end

  defp calculate_position(current_changeset) do
    model = current_changeset.model

    query = from(c in PhoenixTrello.Card,
            select: c.position,
            where: c.list_id == ^(model.list_id),
            order_by: [desc: c.position],
            limit: 1)

    case Repo.one(query) do
      nil      -> put_change(current_changeset, :position, 1024)
      position -> put_change(current_changeset, :position, position + 1024)
    end
  end

  def preload_all(query \\ %{}) do
    comments_query = from c in PhoenixTrello.Comment, order_by: [desc: c.inserted_at], preload: :user

    from c in query, preload: [:members, [comments: ^comments_query]]
  end

  def get_by_user_and_board(query \\ %{}, card_id, user_id, board_id) do
    from c in query,
      left_join: co in assoc(c, :comments),
      left_join: cu in assoc(co, :user),
      left_join: me in assoc(c, :members),
      join: l in assoc(c, :list),
      join: b in assoc(l, :board),
      join: ub in assoc(b, :user_boards),
      where: ub.user_id == ^user_id and b.id == ^board_id and c.id == ^card_id,
      preload: [comments: {co, user: cu }, members: me]
  end
end
