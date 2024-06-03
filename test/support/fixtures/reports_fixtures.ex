defmodule BugReportApi.ReportsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BugReportApi.Reports` context.
  """

  @doc """
  Generate a bug_report.
  """
  def bug_report_fixture(attrs \\ %{}) do
    {:ok, bug_report} =
      attrs
      |> Enum.into(%{
        assignee: "some assignee",
        description: "some description",
        status: "some status",
        tags: "some tags",
        title: "some title"
      })
      |> BugReportApi.Reports.create_bug_report()

    bug_report
  end
end
