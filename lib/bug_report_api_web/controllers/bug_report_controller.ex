defmodule BugReportApiWeb.BugReportController do
  use BugReportApiWeb, :controller

  alias BugReportApi.Reports
  alias BugReportApi.Reports.BugReport

  action_fallback BugReportApiWeb.FallbackController

  def index(conn, _params) do
    bug_reports = Reports.list_bug_reports()
    render(conn, "index.json", bug_reports: bug_reports)
  end

  def create(conn, %{"bug_report" => bug_report_params}) do
    with {:ok, %BugReport{} = bug_report} <- Reports.create_bug_report(bug_report_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bug_report_path(conn, :show, bug_report))
      |> render("show.json", bug_report: bug_report)
    end
  end

  def show(conn, %{"id" => id}) do
    bug_report = Reports.get_bug_report!(id)
    render(conn, "show.json", bug_report: bug_report)
  end

  def update(conn, %{"id" => id, "bug_report" => bug_report_params}) do
    bug_report = Reports.get_bug_report!(id)

    with {:ok, %BugReport{}} <- Reports.update_bug_report(bug_report, bug_report_params) do
      render(conn, "show.json", bug_report: bug_report)
    end
  end

  def delete(conn, %{"id" => id}) do
    bug_report = Reports.get_bug_report!(id)

    with {:ok, %BugReport{}} <- Reports.delete_bug_report(bug_report) do
      send_resp(conn, :no_content, "")
    end
  end
end
