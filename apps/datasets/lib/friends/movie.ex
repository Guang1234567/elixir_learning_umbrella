defmodule Friends.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field(:title, :string)
    field(:tagline, :string)
    has_many(:characters, Friends.Character)
    has_one(:distributor, Friends.Distributor)
    many_to_many(:actors, Friends.Actor, join_through: "movies_actors")
  end

  def insert(%Friends.Movie{} = movie) do
    movie
    |> change()
    |> validate_required([:title])
    |> validate_length(:title, min: 1)
    |> Friends.Repo.insert()
  end

  def insert(%Friends.Movie{} = movie, [%Friends.Actor{}] = actors) do
    movie
    |> change()
    |> validate_required([:title])
    |> validate_length(:title, min: 1)
    |> put_assoc(:actors, actors)
    |> Friends.Repo.insert()
  end

  def insert(%Friends.Movie{} = movie, %Friends.Character{} = character) do
    movie
    |> Ecto.build_assoc(:characters, character)
    |> Friends.Repo.insert()
  end

  def insert(%Friends.Movie{} = movie, %Friends.Distributor{} = distributor) do
    movie
    |> Ecto.build_assoc(:distributor, distributor)
    |> Friends.Repo.insert()
  end
end
