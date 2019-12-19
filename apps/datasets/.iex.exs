# https://samuelmullen.com/articles/customizing_elixirs_iex/

File.exists?(Path.expand("~/.iex.exs")) && import_file("~/.iex.exs")

defmodule IExHelpers do
  def whats_this?(term) when is_nil(term), do: "Type: Nil"
  def whats_this?(term) when is_binary(term), do: "Type: Binary"
  def whats_this?(term) when is_boolean(term), do: "Type: Boolean"
  def whats_this?(term) when is_atom(term), do: "Type: Atom"
  def whats_this?(_term), do: "Type: Unknown"

  def timed(fun, args) do
    {time, result} = :timer.tc(fun, args)
    IO.puts("Time: #{time} μs")
    IO.puts("Result: #{result}")
    result
  end
end


alias Friends.{Movie, Character, Repo, Actor, Distributor}
import Ecto.Changeset

movie = %Movie{title: "Ready Player One", tagline: "Something about video games"}
actor = %Actor{name: "Tyler Sheridan"}
distributor = %Distributor{name: "Netflix"}


#movie = Repo.insert!(movie)
#actor = Repo.insert!(actor)
#movie = Repo.preload(movie, [:distributor, :characters, :actors])
#movie_changeset = Ecto.Changeset.change(movie)
#movie_actors_changeset = movie_changeset |> Ecto.Changeset.put_assoc(:actors, [actor])
#Repo.update!(movie_actors_changeset)
#
#IO.puts "\n多对多插入新的 记录\n"
#
#changeset = movie_changeset |> Ecto.Changeset.put_assoc(:actors, [%{name: "Gary"}])
#Repo.update!(changeset)



defmodule TestEcto do
  def insert(actor, movies) do
    actor
    |> Repo.preload([:movies])
    |> Ecto.Changeset.change()
    #|> validate_required([:name])
    #|> validate_length(:name, min: 1)
    |> Ecto.Changeset.put_assoc(:movies, movies)
    |> Repo.update!()
  end
end


movie = Repo.insert!(movie)
actor = Repo.insert!(actor)


actor = Repo.preload(actor, [:movies])
movie_changeset = Ecto.Changeset.change(actor)
movie_actors_changeset = movie_changeset |> Ecto.Changeset.put_assoc(:movies, [movie])
Repo.update!(movie_actors_changeset)

#TestEcto.insert(actor, [movie])

IO.puts "\n多对多插入新的记录\n"

movie2 = Repo.insert!(%Movie{title: "Ready Player One222", tagline: "Something about video games222"})

actor2 = Repo.preload(actor, [:movies])
movie_changeset = Ecto.Changeset.change(actor2)
movie_actors_changeset = movie_changeset |> Ecto.Changeset.put_assoc(:movies, [movie2])
Repo.update!(movie_actors_changeset)

#TestEcto.insert(actor, [movie2])