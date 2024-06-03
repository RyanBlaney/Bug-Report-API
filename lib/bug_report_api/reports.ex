defmodule BugReportApi.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias BugReportApi.Repo

  alias BugReportApi.Reports.BugReport

  @doc """
  Returns the list of bug_reports.

  ## Examples

      iex> list_bug_reports()
      [%BugReport{}, ...]

  """
  def list_bug_reports do
    Repo.all(BugReport)
  end

  @doc """
  Gets a single bug_report.

  Raises `Ecto.NoResultsError` if the Bug report does not exist.

  ## Examples

      iex> get_bug_report!(123)
      %BugReport{}

      iex> get_bug_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bug_report!(id), do: Repo.get!(BugReport, id)

  @doc """
  Creates a bug_report.

  ## Examples

      iex> create_bug_report(%{field: value})
      {:ok, %BugReport{}}

      iex> create_bug_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bug_report(attrs \\ %{}) do
    %BugReport{}
    |> BugReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bug_report.

  ## Examples

      iex> update_bug_report(bug_report, %{field: new_value})
      {:ok, %BugReport{}}

      iex> update_bug_report(bug_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bug_report(%BugReport{} = bug_report, attrs) do
    bug_report
    |> BugReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bug_report.

  ## Examples

      iex> delete_bug_report(bug_report)
      {:ok, %BugReport{}}

      iex> delete_bug_report(bug_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bug_report(%BugReport{} = bug_report) do
    Repo.delete(bug_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bug_report changes.

  ## Examples

      iex> change_bug_report(bug_report)
      %Ecto.Changeset{data: %BugReport{}}

  """
  def change_bug_report(%BugReport{} = bug_report, attrs \\ %{}) do
    BugReport.changeset(bug_report, attrs)
  end
end
