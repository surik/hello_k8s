defmodule HelloK8s.Person do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloK8s.Repo

  @derive {Jason.Encoder, only: [:id, :name, :age]}
  schema "persons"  do
    field :name, :string
    field :age,  :integer
  end

  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:name, :age])
    |> validate_required([:name, :age])
  end

  def get(), do: Repo.all(__MODULE__)

  def get(id), do: Repo.get(__MODULE__, id)

  def insert(params) do
    params |> IO.inspect
    changeset = changeset(%__MODULE__{}, params)
    if changeset.valid? do
      changeset 
      |> Repo.insert
    else
      changeset
    end
  end

  def delete(id) do
    with post when not is_nil(post) <- get(id),
         {:ok, _} <- Repo.delete(post) do
      :ok
    else
      _ -> {:error, :not_found}
    end
  end
end
