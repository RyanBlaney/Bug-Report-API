defmodule BugReportApi.Reports.BugReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bug_reports" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :assignee, :string
    field :tags, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bug_report, attrs) do
    bug_report
    |> cast(attrs, [:title, :description, :status, :assignee, :tags])
    |> validate_required([:title, :description, :status, :assignee, :tags])
  end
end
