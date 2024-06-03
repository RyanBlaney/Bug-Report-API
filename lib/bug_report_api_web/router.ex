defmodule BugReportApiWeb.Router do
  use BugReportApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BugReportApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BugReportApiWeb do
    pipe_through :browser

    live "/", BugReportLive.Index, :index
    live "/bug_reports/new", BugReportLive.Index, :new
    live "/bug_reports/:id/show/edit", BugReportLive.Show, :edit
    live "/bug_reports/:id/edit", BugReportLive.Index, :edit
    live "/bug_reports/:id", BugReportLive.Show, :show
  end

  scope "/api", BugReportApiWeb do
    pipe_through :api

    resources "/bug_reports", BugReportController, except: [:new, :edit]
  end

  if Application.compile_env(:bug_report_api, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BugReportApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
