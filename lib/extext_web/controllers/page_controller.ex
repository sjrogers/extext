defmodule ExtextWeb.PageController do
  use ExtextWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
