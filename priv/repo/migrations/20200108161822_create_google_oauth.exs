defmodule Ash.Repo.Migrations.CreateGoogleOauth do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :oauth_id, :string
      add :oauth_provider, :string
    end

  end
end
