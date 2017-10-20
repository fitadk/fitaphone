defmodule AstmanWeb.PageController do
  use AstmanWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
