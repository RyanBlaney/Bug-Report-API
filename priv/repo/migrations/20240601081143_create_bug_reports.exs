defmodule BugReportApi.Repo.Migrations.CreateBugReports do
  use Ecto.Migration

  def change do
    create table(:bug_reports) do
      add :title, :string
      add :description, :string
      add :status, :string
      add :assignee, :string
      add :tags, :string

      timestamps(type: :utc_datetime)
    end
  end
end
