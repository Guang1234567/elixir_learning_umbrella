defmodule Friends.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field(:name, :string)
    belongs_to(:movie, Friends.Movie)
  end

  def insert(character, movie) do
    character
    |> change()
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
    |> put_assoc(:movie, movie)
    |> Friends.Repo.insert()
  end
end
