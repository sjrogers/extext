defmodule Extext.Documents do
  @moduledoc false
  def scan(root) do
    glob = root <> "/**/*.md"
    Path.wildcard(glob)
#    |> Path.split
  end

  def scan() do
    Application.get_env(:extext, :directories)
    |> Enum.map(&scan/1)
  end

  def read(filepath) do
    case File.exists?(filepath) do
      true -> {:ok, File.stream!(filepath)}
      _ -> {:err, "File does not exist"}
    end
  end
end
