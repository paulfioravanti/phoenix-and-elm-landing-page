defmodule LandingPage.Marketing.Lead do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__, as: Lead

  @derive {Poison.Encoder, only: [:full_name, :email]}

  schema "leads" do
    field(:email, :string)
    field(:full_name, :string)

    timestamps()
  end

  @doc false
  def changeset(lead, attrs) do
    lead
    |> cast(attrs, [:full_name, :email])
    |> validate_required([:full_name, :email])
    |> unique_constraint(:email)
  end
end
