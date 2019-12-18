defmodule TwitterCloneWeb.PageController do
  use TwitterCloneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def main(conn, _params) do
    render(conn, "main.html")
  end
end
