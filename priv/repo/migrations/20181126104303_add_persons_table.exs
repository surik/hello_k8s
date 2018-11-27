defmodule HelloK8s.Repo.Migrations.AddPersonsTable do
  use Ecto.Migration

  def change do
    create table("persons") do
      add :name, :string
      add :age,  :integer
    end
  end
end
