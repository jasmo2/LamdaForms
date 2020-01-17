defmodule AshWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Ash.Repo

  alias AshWeb.Schema.UserResolver

  object :user do
    field(:id, :id)
    field(:token, :string)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:published_at, :naive_datetime)
  end

  input_object :update_user_params do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string)
  end

  object :user_queries do
    field :user, non_null(:user) do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find/2)
    end

    field :users, list_of(:user) do
      resolve(&UserResolver.all/2)
    end
  end

  object :user_mutations do
    field :create_user, :user do
      arg(:email, :string)
      arg(:first_name, :string)
      arg(:last_name, :string)
      arg(:password, :string)

      resolve fn (attrs, info) ->
        new_attrs = Map.put(attrs, "oauth_provider",  "Email")
        UserResolver.create(new_attrs, info)
      end
    end

    field :create_oauth_user, :user do
      arg(:token, :string)
      resolve(&UserResolver.oauth_create/2)
    end

    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:user, :update_user_params)

      resolve(&UserResolver.update/2)
    end

    field :delete_user, :user do
      arg(:id, non_null(:id))

      resolve(&UserResolver.delete/2)
    end
  end
end
