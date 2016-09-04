defmodule PhoenixTrello.Comment do
  use PhoenixTrello.Web, :model

  @derive {Poison.Encoder, only: [:id, :user, :card_id, :text, :inserted_at]}

  schema "comments" do
    field :text, :string

    belongs_to :user, PhoenixTrello.User
    belongs_to :card, PhoenixTrello.Card

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :card_id, :text])
    |> validate_required([:user_id, :card_id, :text])
  end
end
