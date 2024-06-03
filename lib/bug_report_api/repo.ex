defmodule BugReportApi.Repo do
  use Ecto.Repo,
    otp_app: :bug_report_api,
    adapter: Ecto.Adapters.Postgres
end
