defmodule BugReportApi.ReportsTest do
  use BugReportApi.DataCase

  alias BugReportApi.Reports

  describe "bug_reports" do
    alias BugReportApi.Reports.BugReport

    import BugReportApi.ReportsFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, assignee: nil, tags: nil}

    test "list_bug_reports/0 returns all bug_reports" do
      bug_report = bug_report_fixture()
      assert Reports.list_bug_reports() == [bug_report]
    end

    test "get_bug_report!/1 returns the bug_report with given id" do
      bug_report = bug_report_fixture()
      assert Reports.get_bug_report!(bug_report.id) == bug_report
    end

    test "create_bug_report/1 with valid data creates a bug_report" do
      valid_attrs = %{status: "some status", description: "some description", title: "some title", assignee: "some assignee", tags: "some tags"}

      assert {:ok, %BugReport{} = bug_report} = Reports.create_bug_report(valid_attrs)
      assert bug_report.status == "some status"
      assert bug_report.description == "some description"
      assert bug_report.title == "some title"
      assert bug_report.assignee == "some assignee"
      assert bug_report.tags == "some tags"
    end

    test "create_bug_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_bug_report(@invalid_attrs)
    end

    test "update_bug_report/2 with valid data updates the bug_report" do
      bug_report = bug_report_fixture()
      update_attrs = %{status: "some updated status", description: "some updated description", title: "some updated title", assignee: "some updated assignee", tags: "some updated tags"}

      assert {:ok, %BugReport{} = bug_report} = Reports.update_bug_report(bug_report, update_attrs)
      assert bug_report.status == "some updated status"
      assert bug_report.description == "some updated description"
      assert bug_report.title == "some updated title"
      assert bug_report.assignee == "some updated assignee"
      assert bug_report.tags == "some updated tags"
    end

    test "update_bug_report/2 with invalid data returns error changeset" do
      bug_report = bug_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_bug_report(bug_report, @invalid_attrs)
      assert bug_report == Reports.get_bug_report!(bug_report.id)
    end

    test "delete_bug_report/1 deletes the bug_report" do
      bug_report = bug_report_fixture()
      assert {:ok, %BugReport{}} = Reports.delete_bug_report(bug_report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_bug_report!(bug_report.id) end
    end

    test "change_bug_report/1 returns a bug_report changeset" do
      bug_report = bug_report_fixture()
      assert %Ecto.Changeset{} = Reports.change_bug_report(bug_report)
    end
  end
end
