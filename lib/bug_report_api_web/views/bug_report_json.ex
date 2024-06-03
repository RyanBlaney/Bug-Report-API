defmodule BugReportApiWeb.BugReportJSON do
  use Phoenix.View, root: "lib/bug_report_api_web/templates"

  def render("index.json", %{bug_reports: bug_reports}) do
    %{data: Enum.map(bug_reports, &render_bug_report/1)}
  end

  def render("show.json", %{bug_report: bug_report}) do
    %{data: render_bug_report(bug_report)}
  end

  defp render_bug_report(bug_report) do
    %{
      id: bug_report.id,
      title: bug_report.title,
      description: bug_report.description,
      status: bug_report.status,
      assignee: bug_report.assignee,
      tags: bug_report.tags
    }
  end
end
