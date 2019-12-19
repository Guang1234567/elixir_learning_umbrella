defmodule Friends.Actor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actors" do
    field(:name, :string)
    many_to_many(:movies, Friends.Movie, join_through: "movies_actors")
  end

  def insert(actor) do
    actor
    |> change()
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
    |> Friends.Repo.insert()
  end

  def insert(actor, movies) do
    actor
    |> Friends.Repo.preload([:movies])
    |> change()
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
    |> put_assoc(:movies, movies)
    |> Friends.Repo.update!()
  end

  def update(actor, movies) do
    actor
    |> change()
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
    |> put_assoc(:movies, movies)
    |> Friends.Repo.update()
  end
end
