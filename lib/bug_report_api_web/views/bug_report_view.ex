defmodule BugReportApiWeb.BugReportView do
  use BugReportApiWeb, :view

  def render("index.json", %{bug_reports: bug_reports}) do
    %{data: render_many(bug_reports, BugReportApiWeb.BugReportView, "bug_report.json")}
  end

  def render("show.json", %{bug_report: bug_report}) do
    %{data: render_one(bug_report, BugReportApiWeb.BugReportView, "bug_report.json")}
  end

  def render("bug_report.json", %{bug_report: bug_report}) do
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
