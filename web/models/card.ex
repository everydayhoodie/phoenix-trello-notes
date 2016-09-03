defmodule PhoenixTrello.Card do
  use PhoenixTrello.Web, :model

  @derive {Poison.Encoder, only: [:id, :list_id, :name]}

  schema "cards" do
    field :name, :string
    belongs_to :list, PhoenixTrello.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
