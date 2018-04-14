defmodule ExtextWeb.FilesController do
  @moduledoc false
  use ExtextWeb, :controller

  def index(conn, _params) do
    files = Extext.Documents.scan()
    render conn, "index.json", files: files
  end

  def contents(conn, %{"filepath" => filepath}) do
    case Extext.Documents.read(filepath) do
      {:ok, file} -> render conn, "contents.json", file: file
      _ -> {:err}
    end
  end
end

defmodule ExtextWeb.FilesView do
  def render("index.json", %{files: files}) do
    files
    |> Enum.map(&Path.split/1)
  end

  def render("contents.json", %{file: file}) do
    file |> file_json
  end

  defp file_json(file) do
    %{
      path: file.path,
      lines: Enum.to_list(file)
    }
  end
end
