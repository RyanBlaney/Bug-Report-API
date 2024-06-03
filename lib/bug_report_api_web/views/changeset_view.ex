defmodule BugReportApiWeb.ChangesetView do
  use BugReportApiWeb, :view

  def render("error.json", %{changeset: changeset}) do
    Ecto.Changeset.traverse_errors(changeset, &translate_errors/1)
  end

  defp translate_errors({msg, opts}) do
    # Using gettext here for translations
    Gettext.dgettext(BugReportApiWeb.Gettext, "errors", msg, opts)
  end
end
