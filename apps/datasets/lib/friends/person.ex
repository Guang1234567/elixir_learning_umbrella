defmodule Friends.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field(:name, :string)
    field(:age, :integer, default: 0)
  end

  @fictional_names ["Black Panther", "Wonder Woman", "Spiderman"]

  defp changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
    # |> validate_fictional_name()
    |> validate_inclusion(:name, @fictional_names, message: "is not a superhero !!!")
  end

  defp registration_changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> set_name_if_anonymous()
  end

  defp validate_fictional_name(changeset) do
    name = get_field(changeset, :name)

    if name in @fictional_names do
      changeset
    else
      add_error(changeset, :name, "is not a superhero")
    end
  end

  defp set_name_if_anonymous(changeset) do
    name = get_field(changeset, :name)

    if is_nil(name) || name == "" do
      put_change(changeset, :name, "Anonymous")
    else
      changeset
    end
  end

  @doc """
    Sign up.

    ## Example

    ```
    iex > Friends.Person.sign_up(%{"name"=>"Bob"})

    17:15:16.907 [debug] QUERY OK db=1.8ms queue=1.7ms idle=9884.5ms
    INSERT INTO "people" ("age","name") VALUES ($1,$2) RETURNING "id" [0, "Bob"]
    {:ok,
    %Friends.Person{
     __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
     age: 0,
     id: 4,
     name: "Bob"
    }}
    ```
  """

  def sign_up(params \\ %{}) do
    %Friends.Person{}
    |> registration_changeset(params)
    |> Friends.Repo.insert()
  end
end
