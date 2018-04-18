defmodule ExtextWeb.FilesController do
  @moduledoc false
  use ExtextWeb, :controller

  def index(conn, _params) do
    files = Extext.Documents.scan
    render conn, "index.json", files: files
  end
end

defmodule ExtextWeb.FilesView do
  def render("index.json", %{files: files}) do
    files |> Enum.map(&file_json/1)
  end

  defp file_json(file) do
    %{
      title: file |> Path.basename,
      contents: Extext.Documents.read(file) |> Enum.join
    }
  end
end
