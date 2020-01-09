defmodule Ash.Repo.Migrations.CreateGoogleOauth do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :access_token, :string
    end

  end
end
