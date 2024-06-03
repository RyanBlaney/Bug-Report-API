defmodule BugReportApiWeb.BugReportLive.FormComponent do
  use BugReportApiWeb, :live_component

  alias BugReportApi.Reports

  alias BugReportApiWeb.Router.Helpers, as: Routes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bug_report records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bug_report-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:assignee]} type="text" label="Assignee" />
        <.input field={@form[:tags]} type="text" label="Tags" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bug report</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bug_report: bug_report} = assigns, socket) do
    changeset = Reports.change_bug_report(bug_report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"bug_report" => bug_report_params}, socket) do
    changeset =
      socket.assigns.bug_report
      |> Reports.change_bug_report(bug_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"bug_report" => bug_report_params}, socket) do
    save_bug_report(socket, socket.assigns.action, bug_report_params)
  end

  defp save_bug_report(socket, :edit, bug_report_params) do
    case Reports.update_bug_report(socket.assigns.bug_report, bug_report_params) do
      {:ok, bug_report} ->
        notify_parent({:saved, bug_report})

        {:noreply,
         socket
         |> put_flash(:info, "Bug report updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_bug_report(socket, :new, bug_report_params) do
    case Reports.create_bug_report(bug_report_params) do
      {:ok, bug_report} ->
        notify_parent({:saved, bug_report})

        {:noreply,
         socket
         |> put_flash(:info, "Bug report created successfully")
         |> push_patch(to: Routes.bug_report_index_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
