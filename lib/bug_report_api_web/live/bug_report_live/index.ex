defmodule BugReportApiWeb.BugReportLive.Index do
  use BugReportApiWeb, :live_view

  alias BugReportApi.Reports
  alias BugReportApi.Reports.BugReport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bug_reports, Reports.list_bug_reports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bug report")
    |> assign(:bug_report, Reports.get_bug_report!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bug report")
    |> assign(:bug_report, %BugReport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bug reports")
    |> assign(:bug_report, nil)
  end

  @impl true
  def handle_info({BugReportApiWeb.BugReportLive.FormComponent, {:saved, bug_report}}, socket) do
    {:noreply, stream_insert(socket, :bug_reports, bug_report)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bug_report = Reports.get_bug_report!(id)
    {:ok, _} = Reports.delete_bug_report(bug_report)

    {:noreply, stream_delete(socket, :bug_reports, bug_report)}
  end
end
