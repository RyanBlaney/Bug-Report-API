defmodule BugReportApiWeb.ErrorView do
  use BugReportApiWeb, :view

  def render("404.json", _assigns) do
    %{errors: %{detail: :not_found}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error"}}
  end

  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
