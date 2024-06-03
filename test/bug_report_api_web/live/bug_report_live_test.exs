defmodule BugReportApiWeb.BugReportLiveTest do
  use BugReportApiWeb.ConnCase

  import Phoenix.LiveViewTest
  import BugReportApi.ReportsFixtures

  @create_attrs %{status: "some status", description: "some description", title: "some title", assignee: "some assignee", tags: "some tags"}
  @update_attrs %{status: "some updated status", description: "some updated description", title: "some updated title", assignee: "some updated assignee", tags: "some updated tags"}
  @invalid_attrs %{status: nil, description: nil, title: nil, assignee: nil, tags: nil}

  defp create_bug_report(_) do
    bug_report = bug_report_fixture()
    %{bug_report: bug_report}
  end

  describe "Index" do
    setup [:create_bug_report]

    test "lists all bug_reports", %{conn: conn, bug_report: bug_report} do
      {:ok, _index_live, html} = live(conn, ~p"/bug_reports")

      assert html =~ "Listing Bug reports"
      assert html =~ bug_report.status
    end

    test "saves new bug_report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bug_reports")

      assert index_live |> element("a", "New Bug report") |> render_click() =~
               "New Bug report"

      assert_patch(index_live, ~p"/bug_reports/new")

      assert index_live
             |> form("#bug_report-form", bug_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bug_report-form", bug_report: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bug_reports")

      html = render(index_live)
      assert html =~ "Bug report created successfully"
      assert html =~ "some status"
    end

    test "updates bug_report in listing", %{conn: conn, bug_report: bug_report} do
      {:ok, index_live, _html} = live(conn, ~p"/bug_reports")

      assert index_live |> element("#bug_reports-#{bug_report.id} a", "Edit") |> render_click() =~
               "Edit Bug report"

      assert_patch(index_live, ~p"/bug_reports/#{bug_report}/edit")

      assert index_live
             |> form("#bug_report-form", bug_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bug_report-form", bug_report: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bug_reports")

      html = render(index_live)
      assert html =~ "Bug report updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes bug_report in listing", %{conn: conn, bug_report: bug_report} do
      {:ok, index_live, _html} = live(conn, ~p"/bug_reports")

      assert index_live |> element("#bug_reports-#{bug_report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bug_reports-#{bug_report.id}")
    end
  end

  describe "Show" do
    setup [:create_bug_report]

    test "displays bug_report", %{conn: conn, bug_report: bug_report} do
      {:ok, _show_live, html} = live(conn, ~p"/bug_reports/#{bug_report}")

      assert html =~ "Show Bug report"
      assert html =~ bug_report.status
    end

    test "updates bug_report within modal", %{conn: conn, bug_report: bug_report} do
      {:ok, show_live, _html} = live(conn, ~p"/bug_reports/#{bug_report}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bug report"

      assert_patch(show_live, ~p"/bug_reports/#{bug_report}/show/edit")

      assert show_live
             |> form("#bug_report-form", bug_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bug_report-form", bug_report: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bug_reports/#{bug_report}")

      html = render(show_live)
      assert html =~ "Bug report updated successfully"
      assert html =~ "some updated status"
    end
  end
end
