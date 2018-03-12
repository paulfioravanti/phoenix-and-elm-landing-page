defmodule LandingPage.Marketing.Lead do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__, as: Lead

  @derive {Poison.Encoder, only: [:full_name, :email]}
  @fields ~w(email full_name recaptcha_token)a

  schema "leads" do
    field(:email, :string)
    field(:full_name, :string)
    field(:recaptcha_token, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(%Lead{} = lead, attrs) do
    lead
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:email)
  end
end
