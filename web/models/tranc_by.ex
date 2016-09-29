defmodule Ectoservice.Tranc_by do

  use Ectoservice.Web, :model
#  @foreign_key_type :tranc_id:string
  schema "tranc_by" do
    field :details, :string
    belongs_to :tranc, Ectoservice.Tranc, type: :string
    ##timestamps()
  end
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:details])
    |> validate_required([:details])
  end

end
