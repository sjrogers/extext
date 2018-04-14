defmodule ExtextWeb.FilesController do
  @moduledoc false
  use ExtextWeb, :controller

  def index(conn, _params) do
    files = Extext.Documents.scan()
    render conn, "index.json", files: files
  end
end

defmodule ExtextWeb.FilesView do
  def render("index.json", %{files: files}) do
#    %{ files: Enum.map(files, &file_json/1) }
    files
    |> Enum.map(&Path.split/1)
  end

  defp file_json(file) do
    %{
      path: file.path,
      contents: file.contents
    }
  end
end
