defmodule Friends.Distributor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "distributors" do
    field(:name, :string)
    belongs_to(:movie, Friends.Movie)
  end

  def insert(distributor, movie) do
    distributor
    |> Friends.Repo.preload([:movie])
    |> change()
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
    |> put_assoc(:movie, movie)
    |> Friends.Repo.insert()
  end
end
