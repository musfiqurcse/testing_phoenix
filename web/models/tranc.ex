defmodule Ectoservice.Tranc do

  use Ectoservice.Web, :model

  @primary_key {:name, :string, []}
  @derive { Phoenix.Param, key: :name }

  schema "tranc" do
    ##field :iso_3, :string
    field :details, :string
    field :number, :decimal
    has_many :tranc_by, Ectoservice.Tranc_by, references: :name
    ##timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:details,:number])
    |> validate_required([:details,:number])
  end


end
