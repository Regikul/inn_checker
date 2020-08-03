defmodule InnCheckerWeb.PageController do
  use InnCheckerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
